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
  
  def initialize(id, name, technology, description="")
    raise "Service id cannot be nil" if id.nil?
    raise "Service name cannot be empty" if (name.nil? || name.empty?)
    raise "Unsupported service type" unless %{ SOAP REST }.include?(
        technology.upcase)
    
    @id, @name = id, name
    @technology, @description = technology.upcase, (description || "")
    
    return self
  end # initialize
  
  def endpoint(format=nil)
    endpoint_with_id(@id, format)
  end # endpoint

  def to_s
    return "#{@type} Service:: ID: #{@id}, Name: #{@name}"
  end

# --------------------

  def self.endpoint_with_id(id, format=nil)
    if !format.nil? && !format.empty? && format.class.name=="String"
      URI.join(BioCatalogueClient.HOST.to_s, "/services/#{id}.#{format}")
    else
      URI.join(BioCatalogueClient.HOST.to_s, "/services/#{id}")
    end
  end # self.endpoint_with_id

end
