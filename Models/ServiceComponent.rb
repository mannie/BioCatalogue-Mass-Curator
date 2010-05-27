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
   along with this program.  If not, see http://www.gnu.org/licenses/gpl.html.
=end

class ServiceComponent

  attr_reader :id, :name, :inputs, :outputs
  
  def initialize(uriString)
    @inputs = {}
    @outputs = {}
    
    begin
      @id = uriString.split('/')[-1].to_i
      
      uriString << ".xml"
      serviceURI = URI.parse(uriString)
        
      xmlContent = open(serviceURI).read
      xmlDocument = LibXMLJRuby::XML::Parser.string(xmlContent).parse
      
      propertyNodes = Utilities::XML.getValidChildren(xmlDocument.root)
      propertyNodes.each do |propertyNode|
        case propertyNode.name
          when 'name'
            @name = propertyNode.content
          when 'inputs'
            ins = Utilities::XML.selectNodesWithNameFrom("soapInput",
                propertyNode)
            ins.each { |input|
              id = Utilities::XML.getAttributeFromNode('xlink:href', input)
              id = id.value.split('/')[-1].to_i
              
              name = Utilities::XML.selectNodesWithNameFrom("name", input)[0]
              name = name.content
              
              @inputs.merge!(id => name)
            } # in.each
          when 'outputs'
            outs = Utilities::XML.selectNodesWithNameFrom("soapOutput", 
                propertyNode)
            outs.each { |output|
              id = Utilities::XML.getAttributeFromNode('xlink:href', output)
              id = id.value.split('/')[-1].to_i
              
              name = Utilities::XML.selectNodesWithNameFrom("name", output)[0]
              name = name.content
              
              @outputs.merge!(id => name)
            } # outs.each
        end # case
      end # propertyNodes.each
      
    rescue Exception => ex
      LOG.error "#{ex.class.name} - #{ex.message}\n" << ex.backtrace.join("\n")
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
  
end
