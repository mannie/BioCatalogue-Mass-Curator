#
#  Service.rb
#  BioCatalogue-Mass-Curator
#
#  Created by Mannie Tagarira on 21/05/2010.
#  Copyright (c) 2010 University of Manchester, UK.

=begin
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see http://www.gnu.org/licenses/gpl.html.
=end

class Service
  
  attr_reader :components, :selectedStatusChangeListener
  attr_reader :id, :name, :description, :technology
  attr_reader :variantURI
  
  @componentsFetched = false
  
  def initialize(serviceURIString)
    begin
      @id = serviceURIString.split('/')[-1].to_i
 
      serviceURIString << "/variants.xml"        
      xmlDocument = XMLUtils.getXMLDocumentFromURI(serviceURIString)
    
      propertyNodes = XMLUtils.getValidChildren(xmlDocument.root)
      propertyNodes.each do |propertyNode|
        case propertyNode.name
          when 'name'
            @name = propertyNode.content
          when 'dc:description'
            @description = propertyNode.content
          when 'serviceTechnologyTypes'
            @technology = XMLUtils.getContentOfFirstChild(propertyNode)
          when 'variants'
            variants = XMLUtils.selectNodesWithNameFrom(
                "#{@technology.downcase}Service", propertyNode)
            variants.each { |node|
              @variantURI = XMLUtils.getAttributeFromNode(
                  "xlink:href", node).value
              break if @variantURI
            }
            
            @variantURI = URI.parse(@variantURI)
        end # case
      end # propertyNodes.each
      
      @selectedStatusChangeListener = ServiceCheckBoxListener.new(self)
      
      Cache.addService(self)
      
    rescue Exception => ex
      log('e', ex)
      Cache.removeService(self)
    end # begin rescue
    
    if @name.nil?
      Cache.removeService(self)
      @id = -1
    end
    
    return self
  end # initialize
  
  def fetchComponents
    return true if @componentsFetched

    @components = {}
  
    begin
      xmlDocument = XMLUtils.getXMLDocumentFromURI(@variantURI.to_s + '.xml')
      
      nodeName = (@technology=="SOAP" ? "operations" : nil)
      raise "Only support for SOAP is currently available" if nodeName.nil?
      
      operationsNode = XMLUtils.selectNodesWithNameFrom(
          nodeName, xmlDocument.root)[0]
      
      XMLUtils.getValidChildren(operationsNode).each { |op|
        uriString = XMLUtils.getAttributeFromNode("xlink:href", op).value
        
        component = ServiceComponent.new(uriString)
        next if component.id == -1
        
        @components.merge!(component.id => component)
      }
      
      Cache.addService(self)
      @componentsFetched = true
      
      return true
    rescue Exception => ex
      log('e', ex)
      return false
    end # begin rescue
  end # fetchComponents

  def isSelectedForAnnotation
    !Cache.selectedServices[@id].nil?
  end # isSelectedForAnnotation

  def to_s
    "#{@technology}::#{@id}::#{@name}"
  end # to_s

end
