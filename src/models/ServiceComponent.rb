#
#  ServiceComponent.rb
#  BioCatalogue-Mass-Curator
#
#  Created by Mannie Tagarira on 27/05/2010.
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

class ServiceComponent

  attr_reader :id, :name, :descriptions
  attr_reader :inputs, :outputs
  
  def initialize(uriString)
    @inputs = {}
    @outputs = {}
    
    begin
      @id = uriString.split('/')[-1].to_i      
      xmlDocument = XMLUtil.getXMLDocumentFromURI(uriString)
      propertyNodes = XMLUtil.getValidChildren(xmlDocument.root)
      
      propertyNodes.each do |propertyNode|
        case propertyNode.name
          when 'name'
            @name = propertyNode.content
          when 'dc:description'
            @descriptions = JSONUtil.getAnnotationOfTypeForResource(
                'description', uriString)

            @descriptions << propertyNode.content
            @descriptions.reject! { |d| d.strip.empty? }
          when 'inputs'
            inputs = XMLUtil.selectNodesWithNameFrom("soapInput", propertyNode)
            inputs.each { |inputNode|              
              addServiceComponentIOFromNodeTo(inputNode, @inputs)
            } # inputs.each
          when 'outputs'
            outputs = XMLUtil.selectNodesWithNameFrom("soapOutput", propertyNode)
            outputs.each { |outputNode|
              addServiceComponentIOFromNodeTo(outputNode, @outputs)
            } # outputs.each
        end # case
      end # propertyNodes.each
      
    rescue Exception => ex
      log('e', ex)
    end # begin rescue
    
    if @name.nil?
      @id = -1
      @inputs, @outputs = {}, {}
    end
    
    return self
  end # initialize
  
  def addInput(id, name)
    @inputs.merge!(id => name)
  end # addInput
  
  def addOutput(id, name)
    @outputs.merge!(id => name)
  end # addOutput
  
private
  
  def addServiceComponentIOFromNodeTo(node, destination)
    uriString = XMLUtil.getAttributeFromNode('xlink:href', node).value
    id = uriString.split('/')[-1].to_i

    name, anns = nil, nil
    
    XMLUtil.getValidChildren(node).each { |propertyNode|
      case propertyNode.name
        when 'name'
          name = propertyNode.content
        when 'dc:description'
          anns = JSONUtil.getAnnotationOfTypeForResource('description', 
              uriString)

          anns << propertyNode.content
      end # case
    } # XMLUtil.getValidChildren(outputNode).each
    
    anns.reject! { |d| d.strip.empty? }
    destination.merge!(id => ServiceComponentIO.new(id, name, anns))
  end # getComponentPortFromNode
  
end
