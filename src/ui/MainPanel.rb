#
#  MainPanel.rb
#  BioCatalogue-Mass-Curator
#
#  Created by Mannie Tagarira on 19/05/2010.
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

class MainPanel < JPanel
  
  attr_reader :browseButtonAction
  
  def initialize
    super()
    initUI
    
    return self
  end # initalize
  
private

  def initUI
    self.setLayout(BorderLayout.new)

    buttonPanel = JPanel.new
    buttonPanel.setLayout(GridBagLayout.new)
    
    # set GridBagConstraints
    c = GridBagConstraints.new
    c.anchor = GridBagConstraints::CENTER
    c.fill = GridBagConstraints::BOTH
    c.gridwidth = 1
    c.gridx, c.gridy = 0, 0
    c.ipadx = 10

    # add buttons to panel
    # browse button
    @browseButtonAction = LoadServicesAction.new(self, 1)
    browseButton = JButton.new("Browse Services", Resource.iconFor('scope'))
    buttonPanel.add(browseButton, c)
    browseButton.addActionListener(@browseButtonAction)
    
    # upload button
    c.gridy += 1
    uploadButton = JButton.new("Upload A Spreadsheet", Resource.iconFor(
        'upload'))
    buttonPanel.add(uploadButton, c)
    uploadButton.addActionListener(UploadSpreadsheetAction.new(self))
    
    self.add(buttonPanel)
#    self.add(Component.searchPanel, BorderLayout::NORTH)

  end # initUI
end
