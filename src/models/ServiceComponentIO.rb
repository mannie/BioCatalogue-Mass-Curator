#
#  ServiceComponentIO.rb
#  BioCatalogue-Mass-Curator
#
#  Created by Mannie Tagarira on 28/05/2010.
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

# This is analogous to the following BioCatalogue models:
# SoapInput, SoapOutput, RestParameter (request and response), RestRepresentation (request and response)

# ========================================

class ServiceComponentIO
  
  attr_reader :id, :name, :resourceType, :descriptions
  
  # ACCEPTS: 
  #   id: the ID of the component
  #   resourceName: a human readable name for the object e.g "soap input", "rest parameter"
  #   name: name
  #   descriptions: the descriptions available for this object
  # RETURNS: self
  def initialize(id, resourceName, name, descriptions)
    @id, @name = id, name
    @resourceType = Application.resourceTypeFor(resourceName)
    @descriptions = descriptions.uniq
    
    return self
  end # initialize
  
end # ServiceComponentIO
