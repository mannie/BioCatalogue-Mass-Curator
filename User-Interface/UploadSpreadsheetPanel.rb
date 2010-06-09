#
#  UploadSpreadsheetPanel.rb
#  BioCatalogue-Mass-Curator
#
#  Created by Mannie Tagarira on 20/05/2010.
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

class UploadSpreadsheetPanel < JPanel
  
  attr_reader :selectSpreadsheetButton, :uploadSpreadsheetButton
  attr_reader :selectedSpreadsheetLabel
  attr_reader :usernameField, :passwordField
  
  def initialize
    super()
    @uploadSpreadsheetAction = UploadSpreadsheetAction.new(self)
    
    initUI
    return self
  end # initialize
  
private
  
  def initUI
    self.setLayout(BorderLayout.new)
    
    self.add(selectFilePanel, BorderLayout::NORTH)
    self.add(credentialsPanel)
    self.add(buttonPanel, BorderLayout::SOUTH)    

  end # initUI
  
  def buttonPanel
    panel = JPanel.new
    panel.setLayout(BorderLayout.new)
    
    backButton = JButton.new("Go Back")
    backButton.addActionListener(GoBackAction.new(self))
    panel.add(backButton, BorderLayout::WEST)
    
    @uploadSpreadsheetButton = JButton.new("Upload")
    @uploadSpreadsheetButton.addActionListener(@uploadSpreadsheetAction)
    panel.add(@uploadSpreadsheetButton, BorderLayout::EAST)
    @uploadSpreadsheetButton.setEnabled(false)
    
    return panel
  end # buttonPanel
    
  def credentialsPanel
    panel = JPanel.new

    panel.setLayout(GridBagLayout.new)

    # set constraints
    c = GridBagConstraints.new
    c.insets = (insets = Insets.new(0, 0, 15, 0))
    c.gridx, c.gridy = 1, 0
    c.ipadx = 10
=begin
    # "Login to BioCat" label
    c.anchor = GridBagConstraints::WEST
    loginLabel = JLabel.new("<html><b>Log in to BioCatalogue</b></html>")
    loginLabel.setFont(loginLabel.getFont().deriveFont(13.0))
    panel.add(loginLabel, c);
=end
    # update constraints
    c.insets.set(0, 0, 3, 0)

    # username label 
    c.gridy += 1
    c.gridx = 0
    c.anchor = GridBagConstraints::EAST
    usernameLabel = JLabel.new("BioCatalogue Username:")
    usernameLabel.setLabelFor(@usernameField = JTextField.new("mannie@mygrid.org.uk", 30))
    panel.add(usernameLabel, c)
    
    # username field   
    c.anchor = GridBagConstraints::WEST
    c.gridx = 1
    panel.add(@usernameField, c)

    # password label
    c.anchor = GridBagConstraints::EAST
    c.gridy += 1
    c.gridx = 0
    passwordLabel = JLabel.new("BioCatalogue Password:")
    passwordLabel.setLabelFor(@passwordField = JPasswordField.new("chocolate", 30))
    panel.add(passwordLabel, c)
    
    # password field
    c.anchor = GridBagConstraints::WEST
    c.gridx = 1
    panel.add(@passwordField, c)
=begin
    # remember me checkbox and label
    c.gridy += 1
    c.insets.set(25, 0, 2, 0)
    rememberMeCheckBox = JCheckBox.new("Remember me")
    rememberMeCheckBox.setBorder(BorderFactory.createEmptyBorder())
    panel.add(rememberMeCheckBox, c)

    # upload button
    c.gridy += 1
    c.gridx = 1
    c.anchor = GridBagConstraints::WEST
    c.insets.set(10, 0, 0, 0)
    @uploadSpreadsheetButton = JButton.new("Upload To BioCatalogue")
    @uploadSpreadsheetButton.addActionListener(@uploadSpreadsheetAction)
    panel.add(@uploadSpreadsheetButton, c)
=end
    return panel
  end # credentialsPanel

  def selectFilePanel
    panel = JPanel.new
    panel.setLayout(BorderLayout.new)

    @selectedSpreadsheetLabel = JLabel.new("no file selected", 
        SwingConstants::CENTER)
    @selectedSpreadsheetLabel.setEnabled(false)
    panel.add(@selectedSpreadsheetLabel)
  
    @selectSpreadsheetButton = JButton.new("Select File")
    @selectSpreadsheetButton.addActionListener(@uploadSpreadsheetAction)
    panel.add(@selectSpreadsheetButton, BorderLayout::EAST)
    
    return panel
  end # selectFilePanel
  
end
