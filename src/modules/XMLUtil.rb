#
#  XMLUtil.rb
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

module XMLUtil

  def self.getDocumentFromURI(uri)
    begin
      uri = URI.parse(uri) if uri.class==String
      
      raise "Invalid argument" unless uri.class.name.include?("URI")
      
      xmlContent = open(uri, "Accept" => "application/xml", "User-Agent" => BioCatalogueClient::USER_AGENT).read
      
      return LibXMLJRuby::XML::Parser.string(xmlContent).parse
    rescue Exception => ex
      Notification.errorDialog("No internet connection found.") if ex.class==SocketError
      log('e', ex)
      return nil
    end # begin rescue
  end # self.getDocumentFromURI
  
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
  
  def self.getServiceListingsFromNode(resultsNode, serviceCache, listingCache)
    return false unless resultsNode.name=='results'    

    return false if listingCache.nil? || serviceCache.nil?
    return false unless listingCache.empty? || serviceCache.empty?
    
    serviceNodes = self.selectNodesWithNameFrom("service", resultsNode)
    serviceNodes.each { |node|
      attr = self.getAttributeFromNode("xlink:href", node)
      service = Application.serviceWithURI(attr.value)
               
      next if service.nil? || service.technology!="SOAP" 
      
      listing = ServiceListingPanel.new(service)
      
      serviceCache << service
      listingCache << listing
    }
    
    return true
  end # self.getServiceListingsFromNode
  
end # XMLUtil