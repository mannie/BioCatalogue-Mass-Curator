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

# This is analogous to a BioCatalogue RestMethod or SoapOperation

# ========================================

class ServiceComponent

  attr_reader :id, :name, :descriptions
  attr_reader :inputs, :outputs
  
  # ACCEPTS: a URI to the "service component" in BioCatalogue which is to be created locally
  # This assumes that the following formats:
  #   http(s)://{biocatalogue-instance}/soap_operations/{id}
  #   http(s)://{biocatalogue-instance}/rest_methods/{id}
  # RETURNS: self
  def initialize(uriString)
    @inputs = {}
    @outputs = {}
    
    begin
      @id = uriString.split('/')[-1].to_i      

      document = JSONUtil.getDocumentFromURI(uriString)

      @descriptions = JSONUtil.getAnnotationOfTypeForResource('description', uriString)

      if document['soap_operation'] # SOAP
        @name = document['soap_operation']['name']

        @descriptions << document['soap_operation']['description']

        document['soap_operation']['inputs'].each { |input| addServiceComponentIOFromNodeTo(input, @inputs, "soap input") }
        document['soap_operation']['outputs'].each { |output| addServiceComponentIOFromNodeTo(output, @outputs, "soap output") }
      elsif document['rest_method'] # REST
        if document['rest_method']['name']
          @name = document['rest_method']['name'] + " | " + document['rest_method']['endpoint_label']
        else
          @name = document['rest_method']['endpoint_label']
        end

        @descriptions << document['rest_method']['description']

        document['rest_method']['inputs'].each do |type, list|
          resourceName = resourceNameForRestInputOutputElement(type) or next
          list.each { |input| addServiceComponentIOFromNodeTo(input, @inputs, resourceName) }
        end

        document['rest_method']['outputs'].each do |type, list|
          resourceName = resourceNameForRestInputOutputElement(type) or next
          list.each { |output| addServiceComponentIOFromNodeTo(output, @outputs, resourceName) }
        end
      else # UNSUPPORTED
        raise "Unsupported service component type found: " + uriString.to_s
      end
      
      @descriptions.reject! { |d| d.nil? || d.strip.empty? }
      @descriptions.uniq!
    rescue Exception => ex
      log('e', ex)
    end # begin rescue
    
    if @name.nil?
      @id = -1
      @inputs, @outputs = {}, {}
    end
    
    return self
  end # initialize
    
private
  
  # Helper
  def resourceNameForRestInputOutputElement(element)
    return case element 
             when "representations" : "rest representation"
             when "parameters" : "rest parameter"
             else nil
            end
  end
  
  # This adds either an Input of an Output based on the given JSON node
  # ACCEPTS: 
  #   node: json data
  #   destination: the hash in which to place the created ComponentIO
  #   resourceName: "soap_inputs", "rest_parameters", etc
  def addServiceComponentIOFromNodeTo(node, destination, resourceName)
    uriString = node['resource']
    id = uriString.split('/')[-1].to_i

    name = resourceName.include?("representation") ? node['content_type'] : node['name']

    anns = JSONUtil.getAnnotationOfTypeForResource('description', uriString)
    anns.reject! { |d| d.strip.empty? }
    
    destination.merge!(id => ServiceComponentIO.new(id, resourceName, name, anns))
  end # getComponentPortFromNode
  
end
