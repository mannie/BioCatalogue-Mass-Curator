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
      xmlDocument = Utilities::XML.getXMLDocumentFromURI(serviceURIString)
    
      propertyNodes = Utilities::XML.getValidChildren(xmlDocument.root)
      propertyNodes.each do |propertyNode|
        case propertyNode.name
          when 'name'
            @name = propertyNode.content
          when 'dc:description'
            @description = propertyNode.content
          when 'serviceTechnologyTypes'
            @technology = Utilities::XML.getContentOfFirstChild(propertyNode)
          when 'variants'
            variants = Utilities::XML.selectNodesWithNameFrom(
                "#{@technology.downcase}Service", propertyNode)
            variants.each { |node|
              @variantURI = Utilities::XML.getAttributeFromNode(
                "xlink:href", node).value
              break if @variantURI
            }
            
            @variantURI = URI.parse(@variantURI)
        end # case
      end # propertyNodes.each
      
      @selectedStatusChangeListener = CheckBoxListener.new(self)
      
      Utilities::Application.addServiceToCache(self)
      
    rescue Exception => ex
      log('e', ex)
      Utilities::Application.removeServiceFromCache(self)
    end # begin rescue
    
    if @name.nil?
      Utilities::Application.removeServiceFromCache(self)
      @id = -1
    end
    
    return self
  end # initialize
  
  def fetchComponents
    return true if @componentsFetched

    @components = {}
  
    begin
      xmlDocument = Utilities::XML.getXMLDocumentFromURI(@variantURI.to_s + 
          '.xml')
      
      nodeName = (@technology=="SOAP" ? "operations" : nil)
      raise "Only support for SOAP is currently available" if nodeName.nil?
      
      operationsNode = Utilities::XML.selectNodesWithNameFrom(nodeName, 
          xmlDocument.root)[0]
      
      Utilities::XML.getValidChildren(operationsNode).each { |op|
        uriString = Utilities::XML.getAttributeFromNode("xlink:href", op).value
        
        component = ServiceComponent.new(uriString)
        next if component.id == -1
        
        @components.merge!(component.id => component)
      }
      
      Utilities::Application.addServiceToCache(self)
      @componentsFetched = true
      
      return true
    rescue Exception => ex
      log('e', ex)
      return false
    end # begin rescue
  end # fetchComponents

  def isSelectedForAnnotation
    !BioCatalogueClient.selectedServices[@id].nil?
  end # isSelectedForAnnotation

  def to_s
    "#{@technology}::#{@id}::#{@name}"
  end # to_s

end
