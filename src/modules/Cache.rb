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
   along with this program.  If not, see http://www.gnu.org/licenses/gpl.html
=end

# This module contains helpers specific to maintaining the application's caches

# ========================================

module Cache
  
  @@selectedServices ||= {}
  @@services ||= {}
  @@serviceListings ||= {}

# --------------------

  # RETURNS: a list of all the services loaded from the biocatalogue
  def self.services
    @@services
  end # self.services
  
  # RETURNS: A hash containing all the ServiceListingPanels: { :service_id => [], ... }
  def self.serviceListings
    @@serviceListings
  end # self.serviceListings
  
  # RETURNS: A hash containing all the selected services: { :service_id => service, ... }
  def self.selectedServices
    @@selectedServices.reject! { |id, service| id == -1 }
    @@selectedServices
  end # self.selectedServices

  # ACCEPTS: a Service to add to the "selectedServices" cache
  def self.selectServiceForAnnotation(service)
    isValid = service && service.class==Service && !@@selectedServices.include?(service.id)
    @@selectedServices.merge!(service.id => service) if isValid

    self.updateServiceListings(@@serviceListings[service.id])
  end # self.selectServiceForAnnotation
  
  # ACCEPTS: a Service to remove from the "selectedServices" cache
  def self.deselectServiceForAnnotation(service)
    @@selectedServices.reject! { |key, value| 
      key == service.id 
    } if service && service.class==Service
    
    self.updateServiceListings(@@serviceListings[service.id])
  end # self.deselectServiceForAnnotation
  
  # ACCEPTS: the service to add to the services cache
  def self.addService(service)
    @@services.merge!(service.id => service) if service && service.class==Service
  end # self.addService

  # ACCEPTS: the service to remove from the services cache
  def self.removeService(service)
    self.deselectServiceForAnnotation(service)
    
    @@services.reject! { |key, value| 
      key == service.id 
    } if service && service.class==Service
  end # self.removeService

  # ACCEPTS: the collection that is meant to be updated to the latest version of the services
  # At the moment, the main cache remains untouched
  def self.syncWithCollection(collection)
    # TODO: do a 2 way sync of the services
    collection.each { |service|
      if (cached = @@services[service.id])
          service = cached
        end
      }
  end # self.syncWithCollection(collection)

  # ACCEPTS:
  #   service: the service to ADD a ServiceListingPanel for
  #   listing: the ServiceListingPanel
  def self.addServiceListing(service, listing)
    list = @@serviceListings[service.id] || []
    list << listing
    list.uniq!

    @@serviceListings.merge!(service.id => list) unless @@serviceListings[service.id]
        
    self.updateServiceListings(@@serviceListings[service.id])
  end # self.addServiceListing
  
  # ACCEPTS:
  #   service: the service to REMOVE a ServiceListingPanel for
  #   listing: the ServiceListingPanel
  def self.removeServiceListing(service, listing)
    @@serviceListings[service.id].reject! { |panel| panel==listing }
        
    self.updateServiceListings(@@serviceListings[service.id])
  end # self.removeServiceListing
  
  # ACCEPTS: a collection of ServiceListingPanels
  def self.updateServiceListings(collection)
    collection.each { |panel| panel.refresh } if collection
  end # self.updateServiceListings
  
end # module Cache
