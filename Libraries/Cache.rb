#
#  Cache.rb
#  BioCatalogue-Mass-Curator
#
#  Created by Mannie Tagarira on 09/06/2010.
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

module Cache
  
  @@selectedServices ||= {}
  @@services ||= {}
  @@serviceListings ||= {}

  def self.services
    @@services
  end # self.services
  
  def self.serviceListings
    @@serviceListings
  end # self.serviceListings
  
  def self.selectedServices
    @@selectedServices.reject! { |id, service| id == -1 }
    @@selectedServices
  end # self.selectedServices

  def self.selectServiceForAnnotation(service)
    @@selectedServices.merge!(service.id => service) if service && 
        service.class==Service && !@@selectedServices.include?(service.id)
  end # self.selectServiceForAnnotation
  
  def self.deselectServiceForAnnotation(service)
    @@selectedServices.reject! { |key, value| 
      key == service.id 
    } if service && service.class==Service
  end # self.deselectServiceForAnnotation
  
  def self.addService(service)
    @@services.merge!(service.id => service) if service && 
        service.class==Service
  end # self.addService

  def self.removeService(service)
    self.deselectServiceForAnnotation(service)
    
    @@services.reject! { |key, value| 
      key == service.id 
    } if service && service.class==Service
  end # self.removeService

  def self.syncCollectionWithCache(collection)
     # TODO: do a 2 way sync of the services
    collection.each { |service|
      if (cached = @@services[service.id])
          service = cached
        end
      }
  end # self.syncCollectionWithCache(collection)

  def self.updateServiceListings()
  end # self.updateServiceListings
  
end # module Cache
