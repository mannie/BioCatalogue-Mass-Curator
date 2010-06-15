#
#  ServiceListingPanel.rb
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
   along with this program.  If not, see http://www.gnu.org/licenses/gpl.html
=end

class ServiceListingPanel < JPanel

  attr_reader :showDetail, :checkBox
  
  def initialize(service, showDetail=true)
    super()
    
    @service, @showDetail = service, showDetail
    initUI
    
    Cache.addServiceListing(@service, self)
    
    return self
  end # initialize

  def refresh
    @checkBox.setSelected(@service.isSelectedForAnnotation)
  end # refresh
  
  def dispose
    Cache.removeServiceListing(@service, self)
  end # dispose
  
private
  
  def initUI
    self.setLayout(GridBagLayout.new)
    self.setBorder(BorderFactory.createEtchedBorder())
    
    # set default constraints
    c = GridBagConstraints.new
    c.anchor = GridBagConstraints::NORTHWEST
    c.fill = GridBagConstraints::HORIZONTAL
    c.insets = Insets.new(1, 2, 1, 2)
    c.weightx, c.weighty = 2, 1
    c.gridx, c.gridy = 0, 0
    
    # add checkbox
    @checkBox = JCheckBox.new(@service.name, @service.isSelectedForAnnotation)
    @checkBox.addChangeListener(@service.selectedStatusChangeListener)
    self.add(@checkBox, c)
  
    # add preview button
    c.weightx = GridBagConstraints::REMAINDER
    c.gridx = 1
    previewButton = JButton.new("Preview", Resource.iconFor('url'))
    previewButton.addActionListener(PreviewAction.new(self, @service))
    self.add(previewButton, c)

    if @showDetail
      # add link to biocatalogue
      c.gridx, c.gridy = 0, 1
      c.insets.set(2, 50, 3, 5)
      uriLabel = JLabel.new(@service.technology + ": " + 
          Application.weblinkWithIDForResource(@service.id).to_s)
      uriLabel.setIcon(Resource.iconFor('service'))
      self.add(uriLabel, c)
    end # if @showDetail 
  end # initUI
  
end # ServiceListingPanel
