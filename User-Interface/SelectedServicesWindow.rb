#
#  SelectedServicesWindow.rb
#  BioCatalogue-Mass-Curator
#
#  Created by Mannie Tagarira on 24/05/2010.
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

class SelectedServicesWindow < JFrame
  
  def initialize(title="Services to export")
    super(title)
    
    @@selectedServices ||= []
    @@CONTENT_PANE = self.getContentPane
    
    initUI

    return self
  end # initialize
    
# --------------------
    
  def self.addService(service)
    @@selectedServices << service
    SelectedServicesWindow.showSelectedServices
  end # self.addService
  
  def self.removeService(service)
    @@selectedServices.reject! { |s| s == service }
    SelectedServicesWindow.showSelectedServices
  end # self.removeService
  
private

  def initUI
    SelectedServicesWindow.showSelectedServices
        
    self.setSize(250, 350)
    self.setLocation(70, 75)
    self.setDefaultCloseOperation(JFrame::DO_NOTHING_ON_CLOSE)

    self.visible = true
  end # initUI

  def self.showSelectedServices
    @@CONTENT_PANE.setLayout(GridLayout.new(0, 1))

    @@selectedServices.uniq!
    
    @@selectedServices.each { |listing|
      @@CONTENT_PANE.add(JLabel.new(listing.to_s))
    } # @@SELECTED_SERVICES.each
    
    @@CONTENT_PANE.repaint
  end # showSelectedServices
  
end
