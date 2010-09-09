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
   along with this program.  If not, see http://www.gnu.org/licenses/gpl.html
=end

# This module contains information needed by the application in order to make HTTP requests

# ========================================

module BioCatalogueClient
  
  @@userCredentials ||= { :username => '', :password => '' }
  
  HOSTNAME = URI.parse(CONFIG['application']['biocatalogue-hostname'])
  USER_AGENT = "Mass Curator (Alpha) - JRuby/#{JRUBY_VERSION}"
  
# --------------------
  
  def self.currentUser
    @@userCredentials.clone.freeze
  end # self.currentUser

  # ACCEPTS: username, password
  def self.setCurrentUser(user, pass)
    @@userCredentials[:username] = user
    @@userCredentials[:password] = pass
  end # self.currentUser(user, pass)
  
  # ACCEPTS: 
  #   query: the search term you want to search the biocatalogue for
  #   format: the representation you would like the data in e.g. "json"; default=nil
  #   perPage: the number of items to fetch per page; default=25
  #   page: the page you would like to fetch; default=1
  #   scope: the scope you would like to base you search on; default='services'
  # RETURNS: a URI for the search endpoint which contains all the given filters
  def self.searchEndpoint(query, format=nil, perPage=25, page=1, scope='services')
    query = URI.escape(query.strip)
    
    if !format.nil? && !format.empty? && format.class==String
      URI.join(HOSTNAME.to_s, "/search.#{format}?q=#{query}&scope=#{scope}&page=#{page}&per_page=#{perPage}")
    else
      URI.join(HOSTNAME.to_s, "/search?q=#{query}")
    end
  end # self.searchEndpoint

  # ACCEPTS: 
  #   format: the representation you would like the data in e.g. "json"; default=nil
  #   perPage: the number of items to fetch per page; default=25
  #   page: the page you would like to fetch; default=1
  #   serviceType: the type of services you want to show in the index e.g. "SOAP", "REST"; default=''
  # RETURNS: a URI for the search endpoint which contains all the given filters
  def self.servicesEndpoint(format=nil, perPage=25, page=1, serviceType='')
    if !format.nil? && !format.empty? && format.class==String
      URI.join(HOSTNAME.to_s, "/services.#{format}?per_page=#{perPage}&page=#{page}&t=[#{serviceType}]")
    else
      URI.join(HOSTNAME.to_s, "/services")
    end
  end # self.servicesEndpoint

end # BioCatalogueClient
