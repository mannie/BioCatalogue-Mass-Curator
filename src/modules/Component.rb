#
#  Component.rb
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

module Component

  def self.centerToParent(dependant, parent)
    x = parent.getLocationOnScreen.getX + (parent.getWidth / 2) - (dependant.getWidth / 2)
    y = parent.getLocationOnScreen.getY	+ (parent.getHeight / 2) - (dependant.getHeight / 2)

    dependant.setLocation(x, y)
  end # self.centerToParent

  def self.centerToDisplay(component)
    screenSize = Toolkit.getDefaultToolkit.getScreenSize

    x = (screenSize.getWidth / 2) - (component.getWidth / 2)
    y = (screenSize.getHeight / 2) - (component.getHeight / 2)

    component.setLocation(x, y)
  end # self.centerToDisplay

  def self.flash(component)
    component.setVisible(false)
    component.setVisible(true)
  end # self.flash

  def self.searchPanel
    @@searchPanel ||= SearchPanel.new
  end # self.searchPanel
  
  def self.searchField
    self.searchPanel.searchField
  end # self.searchField

  def self.searchButton
    self.searchPanel.searchButton
  end # self.searchButton
  
  def self.browsingStatusPanel
    @@browsingStatusPanel ||= BrowsingStatusPanel.new
  end # self.browsingStatusPanel
  
  def self.exportButton
    self.browsingStatusPanel.exportButton
  end # self.exportButton

end # module Component
