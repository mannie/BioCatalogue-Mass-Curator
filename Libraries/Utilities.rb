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
    
    def self.syncCollectionWithCache(collection)
      collection.each { |service|
        if (cached = BioCatalogueClient.cachedServices[service.id])
            service = cached
          end
        }
    end # self.syncCollectionWithCache(collection)

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
  
  module XML
  
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