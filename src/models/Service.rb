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
   along with this program.  If not, see http://www.gnu.org/licenses/gpl.html
=end

class Service
  
  attr_reader :components, :descriptions 
  attr_reader :id, :name, :technology
  attr_reader :variantURI, :selectedStatusChangeListener
  
  @componentsFetched = false
  
  def initialize(serviceURIString)
    begin
      @id = serviceURIString.split('/')[-1].to_i
      @descriptions = []
       
      serviceURIString << "/variants.xml"        
      xmlDocument = XMLUtil.getXMLDocumentFromURI(serviceURIString)
    
      propertyNodes = XMLUtil.getValidChildren(xmlDocument.root)
      propertyNodes.each do |propertyNode|
        case propertyNode.name
          when 'name'
            @name = propertyNode.content
          when 'dc:description'
            @descriptions << propertyNode.content
          when 'serviceTechnologyTypes'
            @technology = XMLUtil.getContentOfFirstChild(propertyNode)
          when 'variants'
            variants = XMLUtil.selectNodesWithNameFrom(
                "#{@technology.downcase}Service", propertyNode)
            variants.each { |node|
              @variantURI = XMLUtil.getAttributeFromNode(
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
  
  def fetchComponents(force=false)
    return true if @componentsFetched && !force

    @components = {}
  
    begin
      # get descriptions
      @descriptions << JSONUtil.getAnnotationOfTypeForResource('description', 
          @variantURI)
      @descriptions.flatten!
      @descriptions.reject! { |d| d.strip.empty? }
      
      xmlDocument = XMLUtil.getXMLDocumentFromURI(@variantURI.to_s + '.xml')
      
      nodeName = (@technology=="SOAP" ? "operations" : nil)
      raise "Only support for SOAP is currently available" if nodeName.nil?
      
      operationsNode = XMLUtil.selectNodesWithNameFrom(
          nodeName, xmlDocument.root)[0]
      
      XMLUtil.getValidChildren(operationsNode).each { |op|
        uriString = XMLUtil.getAttributeFromNode("xlink:href", op).value
        
        component = ServiceComponent.new(uriString)
        next if component.id == -1
        
        @components.merge!(component.id => component)
      }
      
      Cache.addService(self)
      @componentsFetched = true
      
      p self.inspect
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

end # Service