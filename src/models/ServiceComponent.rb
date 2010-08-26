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
    
    # TODO: support for REST services
    begin
      @id = uriString.split('/')[-1].to_i      

      document = JSONUtil.getDocumentFromURI(uriString)
      
      @name = document['soap_operation']['name']

      @descriptions = JSONUtil.getAnnotationOfTypeForResource('description', uriString)
      @descriptions << document['soap_operation']['description']
      @descriptions.reject! { |d| d.nil? || d.strip.empty? }

      document['soap_operation']['inputs'].each { |input| addServiceComponentIOFromNodeTo(input, @inputs, "soap input") }
      document['soap_operation']['outputs'].each { |output| addServiceComponentIOFromNodeTo(output, @outputs, "soap output") }      
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
  
  def addServiceComponentIOFromNodeTo(node, destination, resourceName)
    uriString = node['resource']
    id = uriString.split('/')[-1].to_i

    name = node['name']
    anns = JSONUtil.getAnnotationOfTypeForResource('description', uriString)
    anns.reject! { |d| d.strip.empty? }
    
    destination.merge!(id => ServiceComponentIO.new(id, resourceName, name, anns))
  end # getComponentPortFromNode
  
end
