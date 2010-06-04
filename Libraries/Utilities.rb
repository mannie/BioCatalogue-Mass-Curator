#
#  Utilities.rb
#  BioCatalogue-Mass-Curator
#
#  Created by Mannie Tagarira on 25/05/2010.
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

module Utilities

  module Application
    
    def self.postAnnotationData(jsonContent, user, pass)
      begin            
        request = Net::HTTP::Post.new("/annotations/bulk_create")
        request.basic_auth(user, pass)
        request.body = jsonContent
        request.content_type = 'application/json'
        request.add_field("Accept", 'application/json')
        
        Net::HTTP.new(BioCatalogueClient.HOST.host).start { |http|
          response = http.request(request)
          log('w', nil, "do after POST checks on response")
          p response.inspect, response.content_type, response.body
        }
        
        return true
      rescue Exception => ex
        log('e', ex)
        return nil
      end # begin rescue

    end # self.postAnnotationData
    
    def self.selectServiceForAnnotation(service)
      BioCatalogueClient.selectedServices.merge!(service.id => service) if 
          service && service.class==Service && 
          !BioCatalogueClient.selectedServices.include?(service.id)
    end # self.addService
    
    def self.deselectServiceForAnnotation(service)
      BioCatalogueClient.selectedServices.reject! { |key, value| 
        key == service.id 
      } if service && service.class==Service
    end # self.removeService
    
    def self.addServiceToCache(service)
      BioCatalogueClient.cachedServices.merge!(service.id => service) if 
          service && service.class==Service
    end # self.cacheService

    def self.removeServiceFromCache(service)
      self.deselectServiceForAnnotation(service)
      
      BioCatalogueClient.cachedServices.reject! { |key, value| 
        key == service.id 
      } if service && service.class==Service
    end # self.cacheService

    def self.syncCollectionWithCache(collection)
      collection.each { |service|
        if (cached = BioCatalogueClient.cachedServices[service.id])
            service = cached
          end
        }
    end # self.syncCollectionWithCache(collection)

    def self.weblinkWithIDForResource(id, resource="service", format=nil)
      return nil if !format.nil? && format.class!=String
      return nil if resource.nil? || resource.class!=String
      
      path = "/#{resource}/#{id}"
      path += ".#{format}" if format
      
      return URI.join(BioCatalogueClient.HOST.to_s, path)
    end # self.weblinkWithID
    
    def self.resourceNameFor(thing)
      case thing.downcase
        when "soap service", "rest service": "services"
        when "soap input": "soap_inputs"
        when "soap output": "soap_outputs"
        when "soap operation": "soap_operations"
        else nil
      end # case
    end # resourceNameFor
    
  end # module Application
  
# ========================================

  module Components

    def self.centerComponentTo(dependant, parent)
      x = parent.getLocationOnScreen.getX + 
          (parent.getWidth / 2) - 
          (dependant.getWidth / 2)
    
      y = parent.getLocationOnScreen.getY	+ 
          (parent.getHeight / 2) - 
          (dependant.getHeight / 2)

      dependant.setLocation(x, y)
    end # self.centerComponentTo

    def self.centerComponentToDisplay(component)
      screenSize = Toolkit.getDefaultToolkit.getScreenSize

      x = (screenSize.getWidth / 2) - (component.getWidth / 2)
      y = (screenSize.getHeight / 2) - (component.getHeight / 2)

      component.setLocation(x, y)
    end # self.centerComponentToScreen

    def self.flashComponent(component)
      component.setVisible(false)
      component.setVisible(true)
    end # self.flashComponent

  end # module Components
  
# ========================================

  module Notification
    
    def self.errorDialog(msg, title="Error")
      JOptionPane.showMessageDialog(MAIN_WINDOW, msg, title, 
          JOptionPane::ERROR_MESSAGE)
    end # self.errorDialog
    
    def self.informationDialog(msg, title="Information")
      JOptionPane.showMessageDialog(MAIN_WINDOW, msg, title, 
          JOptionPane::INFORMATION_MESSAGE)
    end # self.informationDialog
    
  end # module Notification
  
# ========================================
  
  module XML
  
    def self.getXMLDocumentFromURI(uri)
      begin
        uri = URI.parse(uri) if uri.class==String
        
        raise "Invalid argument" unless uri.class.name.include?("URI")
        
        userAgent = "BioCatalogue Mass Curator Alpha; JRuby/#{JRUBY_VERSION}"
        xmlContent = open(uri, "Accept" => "application/xml", 
            "User-Agent" => userAgent).read
        
        return LibXMLJRuby::XML::Parser.string(xmlContent).parse
      rescue Exception => ex
        log('e', ex)
        return nil
      end # begin rescue
    end # self.getXMLDocumentFromURI
    
    def self.getAttributeFromNode(attribute, node)
      node.attributes.select { |a| "xlink:href"==a.name }[0]
    end # self.getAttributeFromNode
    
    def self.getValidChildren(node)
      node.children.reject { |n| n.name == "#text" }
    end # self.getValidChildren
    
    def self.getContentOfFirstChild(node)
      node.child.next.content
    end # self.getContentOfFirstChild
    
    def self.selectNodesWithNameFrom(name, parent)
      parent.children.select { |n| n.name == name }
    end # self.selectNodesWithName
    
  end # module XML

end