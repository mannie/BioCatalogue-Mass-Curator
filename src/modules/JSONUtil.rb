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

module JSONUtil

  def self.paginatedCollection(collection, fromURI)
    begin
      page = 1
      perPage = 50

      paginatedCollection = {}
      
      while
        uri = URI.parse(fromURI.to_s.gsub(/\/$/, '') +
            "/#{collection}.json?page=#{page}&per_page=#{perPage}")

        jsonContent = open(uri, "Accept" => "application/json").read

        elements = JSON(jsonContent)
        break if elements.empty?
        
        paginatedCollection.merge!(page => elements)
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
      annotationsForPage = self.paginatedCollection("annotations", resourceURI)
      
      requestedAnnotations = []

      annotationsForPage.each do |page, annotations|
        annotations.each do |annotation|
          resource = annotation['annotation']['annotatable']['resource']
          next unless resource.to_s==resourceURI.to_s 
          
          type = annotation['annotation']['attribute']['name']
          next unless type==annotationType

          requestedAnnotations << annotation['annotation']['value']['content']
        end # annotations.each
      end # annotationsForPage.each

      return requestedAnnotations.uniq.clone
    rescue Exception => ex
      log('e', ex)
      return nil
    end # begin rescue
  end # self.getAnnotationOfTypeFrom

end # JSONUtil
