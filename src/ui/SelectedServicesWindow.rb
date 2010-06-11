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
  
  @@previouslyUsedPanel = nil
  @@previouslyUsedListings= []
  
  def initialize(title="Services to export")
    super(title)
    initUI
    return self
  end # initialize

  def refreshSelectedServices
    listPanel = JPanel.new
    listPanel.setLayout(GridLayout.new(0, 1))
    
    c = GridBagConstraints.new
    c.anchor = GridBagConstraints::NORTHWEST
    c.insets = Insets.new(1, 1, 1, 1)
    c.fill = GridBagConstraints::HORIZONTAL
    c.weightx
    c.gridy = 0
    
    @@previouslyUsedListings.each { |listingPanel| listingPanel.dispose }
    
    @@previouslyUsedListings= []
    
    Cache.selectedServices.each { |id, service|
      listPanel.add(listing = ServiceListingPanel.new(service, false))
      @@previouslyUsedListings << listing
      c.gridy += 1
    }
    
    scrollPane = JScrollPane.new(listPanel)
    self.getContentPane.add(scrollPane)
    
    self.remove(@@previouslyUsedPanel) if @@previouslyUsedPanel
    @@previouslyUsedPanel = scrollPane

    self.pack
  end # showSelectedServices
  
private

  def initUI
    self.getContentPane.setLayout(BorderLayout.new)

    refreshSelectedServices
        
    self.setMaximumSize(Dimension.new(300, 600))
    self.setMinimumSize(Dimension.new(300, 100))

    self.setLocation(70, 75)
    self.setDefaultCloseOperation(JFrame::DISPOSE_ON_CLOSE)

    self.setVisible(true)
  end # initUI
  
end
