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
  
  attr_reader :id, :name, :description, :technology
  
  def initialize(serviceURIString)
    begin
      LOG.warn "TODO: error handling for uris that are not => /services/{id}"
      
      @id = serviceURIString.split('/')[-1].to_i
 
      if (cachedService = BioCatalogueClient.cachedServices[@id]) # cached
        @name = cachedService.name
        @description = cachedService.description
        #@technology = cachedService.technology
        cachedService = self
      else # not cached
        serviceURIString << ".xml"

        serviceURI = URI.parse(serviceURIString)
        
        xmlContent = open(serviceURI).read
        xmlDocument = LibXMLJRuby::XML::Parser.string(xmlContent).parse
      
        propertyNodes = xmlDocument.root.children.reject { |n| n.name == "#text" }
        propertyNodes.each do |propertyNode|
          case propertyNode.name
            when 'name'
              @name = propertyNode.content
            when 'dc:description'
              @description = propertyNode.content
            when 'serviceTechnologyTypes'
              @technology = propertyNode.child.next.content
          end # case
        end # propertyNodes.each
      end # if else cached
      
      BioCatalogueClient.addServiceToCache(self)
      
    rescue Exception => ex
      LOG.error "#{ex.class.name} - #{ex.message}\n" << ex.backtrace.join("\n")
      BioCatalogueClient.removeServiceFromCache(self)
    end
    
    if @name.nil?
      BioCatalogueClient.removeServiceFromCache(self)
      @id = -1
    end
    
    return self
  end # initialize
  
  def endpoint(format=nil)
    endpoint_with_id(@id, format)
  end # endpoint

  def to_s
    return "#{@technology} Service:: ID: #{@id}, Name: #{@name}"
  end # to_s

# --------------------

  def self.endpoint_with_id(id, format=nil)
    if !format.nil? && !format.empty? && format.class.name=="String"
      URI.join(BioCatalogueClient.HOST.to_s, "/services/#{id}.#{format}")
    else
      URI.join(BioCatalogueClient.HOST.to_s, "/services/#{id}")
    end
  end # self.endpoint_with_id

end
