#
#  JSONUtil.rb
#  BioCatalogue-Mass-Curator
#
#  Created by Mannie Tagarira on 17/06/2010.
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

# This module is a helper for all things JSON in the app

# ========================================

module JSONUtil

  def self.getDocumentFromURI(uri)
    begin
      uri = URI.parse(uri) if uri.class==String
      
      raise "Invalid argument" unless uri.class.name.include?("URI")
      
      jsonContent = open(uri, "Accept" => "application/json", "User-Agent" => BioCatalogueClient::USER_AGENT).read
      
      return JSON(jsonContent)
    rescue Exception => ex
      Notification.errorDialog("No internet connection found.") if ex.class==SocketError
      log('e', ex)
      return nil
    end # begin rescue
  end # self.getDocumentFromURI

  def self.paginatedCollection(collection, fromURI)
    begin
      page = 1
      perPage = 50

      paginatedCollection = {}

      # check whether hitting this endpoint will trigger a redirection or not
      willRedirect = false
      willRedirectTo = nil
      
      redirectionCheckURI = URI.parse(removeTrailingSlash(fromURI.to_s) + "/#{collection}.json")
      request = Net::HTTP::Get.new(redirectionCheckURI.path)
      Net::HTTP.start(redirectionCheckURI.host, redirectionCheckURI.port) { |http|
        response = http.request(request)
        
        if response.is_a?(Net::HTTPRedirection)
          willRedirectTo = URI.parse(response['location'])
          willRedirect = true
        end
      }

      # fetch the required collection
      while true
        queryParameters = "page=#{page}&per_page=#{perPage}"
        
        if willRedirect
          uri = URI.parse(willRedirectTo.to_s + "&#{queryParameters}")
        else
          uri = URI.parse(removeTrailingSlash(fromURI.to_s) + "/#{collection}.json?#{queryParameters}")
        end

        document = self.getDocumentFromURI(uri)
        raise "Could not find 'results' element from #{uri.to_s}" if document[collection]['results'].nil?
        break if page > document[collection]['pages']
                
        paginatedCollection.merge!(page => document[collection]['results'])
        page += 1
      end
      
      return paginatedCollection
    rescue Exception => ex
      log('e', ex)
      return {}
    end # begin rescue
  end # self.paginatedCollection
  
  def self.getAnnotationOfTypeForResource(annotationType, resourceURI)
    begin      
      requestedAnnotations = []

      paginatedAnnotations = self.paginatedCollection("annotations", resourceURI)
      paginatedAnnotations.each do |page, annotations|
        annotations.each do |annotation|
          annotatable = annotation['annotatable']['resource']
          next unless annotatable.to_s==resourceURI.to_s 
          
          attribute = annotation['attribute']['name']
          next unless attribute==annotationType

          requestedAnnotations << annotation['value']['content']
        end # annotations.each
      end # paginatedAnnotations.each

      return requestedAnnotations.uniq.clone
    rescue Exception => ex
      log('e', ex)
      return nil
    end # begin rescue
  end # self.getAnnotationOfTypeFrom

  def self.getServiceListingsFromNode(resultsNode, serviceCache, listingCache)
    return false unless resultsNode.is_a?(Array)    

    return false if listingCache.nil? || serviceCache.nil?
    return false unless listingCache.empty? || serviceCache.empty?
    
    resultsNode.each { |node|
      service = Application.serviceWithURI(node['resource'])
      
      listing = ServiceListingPanel.new(service)
      
      serviceCache << service
      listingCache << listing
    }
    
    return true
  end # self.getServiceListingsFromNode

private
  
  def self.removeTrailingSlash(string)
    string.gsub(/\/$/, '')
  end
  
end # JSONUtil
