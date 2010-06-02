#
#  BioCatalogueClient.rb
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

class BioCatalogueClient
  
  def initialize(base="http://www.biocatalogue.org")
    @@HOST ||= URI.parse(base)
    
    @@selectedServices ||= {}
    @@cachedServices ||= {}
    @@SEARCH ||= SearchAction.new
    @@user = nil
  end # initialize
  
# --------------------
  
  def self.loggedIn
    !@@user.nil?
  end
  
  def self.SEARCH
    @@SEARCH
  end
    
  def self.HOST
    @@HOST
  end # self.HOST
  
  def self.cachedServices
    @@cachedServices
  end # self.cachedServices
  
  def self.selectedServices
#    @@selectedServices.reject! { |id, service| id == -1 }
    @@selectedServices
  end # self.selectedServices
  
  def self.servicesEndpoint(format=nil, perPage=25, page=1, filter='')
    if !format.nil? && !format.empty? && format.class.name=="String"
      URI.join(@@HOST.to_s, 
          "/services.#{format}?per_page=#{perPage}&page=#{page}&t=[#{filter}]")
    else
      URI.join(@@HOST.to_s, "/services")
    end
  end # self.servicesEndpoint
  
  def self.selectServiceForAnnotation(service)
    @@selectedServices.merge!(service.id => service) if service && 
        service.class==Service && !@@selectedServices.include?(service.id)
  end # self.addService
  
  def self.deselectServiceForAnnotation(service)
    @@selectedServices.reject! { |key, value| 
      key == service.id 
    } if service && service.class==Service
  end # self.removeService
  
  def self.addServiceToCache(service)
    @@cachedServices.merge!(service.id => service) if service &&
        service.class==Service
  end # self.cacheService

  def self.removeServiceFromCache(service)
    self.deselectServiceForAnnotation(service)
    
    @@cachedServices.reject! { |key, value| 
      key == service.id 
    } if service && service.class==Service
  end # self.cacheService
  
end
