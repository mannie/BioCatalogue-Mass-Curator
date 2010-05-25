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
   along with this program.  If not, see http://www.gnu.org/licenses/gpl.html.
=end

class ServiceListingPanel < JPanel

  def initialize(service)
    super()
    
    @service = service
    
    initUI
    return self
  end # initialize

private
  
  def initUI
    self.setLayout(GridBagLayout.new)
    
    c = GridBagConstraints.new
    c.anchor = GridBagConstraints::NORTHWEST
    c.fill = GridBagConstraints::HORIZONTAL
    c.insets = Insets.new(2, 5, 3, 5)
    c.weightx = 2
    c.gridx, c.gridy = 0, 0
 
    checkBox = JCheckBox.new(@service.name, false)
    checkBox.addChangeListener(CheckBoxListener.new(@service))
    self.add(checkBox, c)
        
    c.weightx = GridBagConstraints::REMAINDER
    c.gridwidth = 1
    c.gridx = 1
    previewButton = JButton.new("Preview")
    previewButton.addActionListener(PreviewAction.new(self, @service))
    
    self.add(previewButton, c)
  end # initUI
  
end
