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

module BioCatalogueClient
  
  @@userCredentials ||= { :username => '', :password => '' }
  
  HOSTNAME = URI.parse(CONFIG['application']['biocatalogue-hostname'])
  USER_AGENT = "Mass Curator (Alpha) - JRuby/#{JRUBY_VERSION}"
  
# --------------------
  
  def self.currentUser
    @@userCredentials.clone.freeze
  end # self.currentUser
  
  def self.setCurrentUser(user, pass)
    @@userCredentials[:username] = user
    @@userCredentials[:password] = pass
  end # self.currentUser(user, pass)
      
  def self.searchEndpoint(query, format=nil, perPage=25, page=1, scope='services')
    query = URI.escape(query.strip)
    
    if !format.nil? && !format.empty? && format.class==String
      URI.join(HOSTNAME.to_s, "/search.#{format}?q=#{query}&scope=#{scope}&page=#{page}&per_page=#{perPage}")
    else
      URI.join(HOSTNAME.to_s, "/search?q=#{query}")
    end
  end # self.searchEndpoint

  def self.servicesEndpoint(format=nil, perPage=25, page=1, filter='')
    if !format.nil? && !format.empty? && format.class==String
      URI.join(HOSTNAME.to_s, "/services.#{format}?per_page=#{perPage}&page=#{page}&t=[#{filter}]")
    else
      URI.join(HOSTNAME.to_s, "/services")
    end
  end # self.servicesEndpoint
  
private
  
  

end # BioCatalogueClient
