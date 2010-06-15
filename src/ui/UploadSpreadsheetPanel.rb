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
   along with this program.  If not, see http://www.gnu.org/licenses/gpl.html
=end

class UploadSpreadsheetPanel < JPanel
  
  attr_reader :selectSpreadsheetButton, :uploadSpreadsheetButton
  attr_reader :selectedSpreadsheetLabel
  attr_reader :usernameField, :passwordField, :uploadSpreadsheetAction
  
  def initialize
    super()
    
    @uploadSpreadsheetAction = UploadSpreadsheetAction.new(self)
    
    @selectedSpreadsheetLabel = JLabel.new("no file selected", 
        SwingConstants::CENTER)
    @selectedSpreadsheetLabel.setEnabled(false)
  
    @selectSpreadsheetButton = JButton.new("Select File", 
        Resource.iconFor('folder'))
    @selectSpreadsheetButton.addActionListener(@uploadSpreadsheetAction)

    initUI
    return self
  end # initialize
  
  def spreadsheetSpecified
    @selectedSpreadsheetLabel.isEnabled
  end # spreadsheetSpecified
  
private
  
  def initUI
    self.setLayout(BorderLayout.new)
    
    self.add(mainPanel)
    self.add(buttonPanel, BorderLayout::SOUTH)
  end # initUI
  
  def buttonPanel
    panel = JPanel.new
    panel.setLayout(BorderLayout.new)
    
    backButton = JButton.new("Go Back", Resource.iconFor('home'))
    backButton.addActionListener(GoBackAction.new(self))
    panel.add(backButton, BorderLayout::WEST)
    
    @uploadSpreadsheetButton = JButton.new("Upload", Resource.iconFor('upload'))
    @uploadSpreadsheetButton.addActionListener(@uploadSpreadsheetAction)
    panel.add(@uploadSpreadsheetButton, BorderLayout::EAST)
    @uploadSpreadsheetButton.setEnabled(false)
    
    return panel
  end # buttonPanel
    
  def mainPanel
    panel = JPanel.new
    panel.setLayout(GridBagLayout.new)
    keyListener = CredentialsKeyListener.new(self)
    
    # set constraints
    c = GridBagConstraints.new
    c.insets = Insets.new(0, 0, 75, 0)
    c.gridx, c.gridy = 1, 0
    c.ipadx = 10

    # selected spreadsheet label 
    c.gridy += 1
    c.gridx = 1
    c.anchor = GridBagConstraints::EAST
    panel.add(@selectedSpreadsheetLabel, c)
    
    # select spreadsheet button   
    c.anchor = GridBagConstraints::WEST
    c.gridx = 0
    panel.add(@selectSpreadsheetButton, c)

    # update constraints
    c.insets.set(0, 0, 3, 0)
    
    # username label 
    c.gridy += 1
    c.gridx = 0
    c.anchor = GridBagConstraints::EAST
    usernameLabel = JLabel.new("BioCatalogue Username:")
    usernameLabel.setLabelFor(@usernameField = JTextField.new(30))
    panel.add(usernameLabel, c)
    
    # username field   
    c.anchor = GridBagConstraints::WEST
    c.gridx = 1
    panel.add(@usernameField, c)
    @usernameField.addKeyListener(keyListener)

    # password label
    c.anchor = GridBagConstraints::EAST
    c.gridy += 1
    c.gridx = 0
    passwordLabel = JLabel.new("BioCatalogue Password:")
    passwordLabel.setLabelFor(@passwordField = JPasswordField.new(30))
    panel.add(passwordLabel, c)
    
    # password field
    c.anchor = GridBagConstraints::WEST
    c.gridx = 1
    panel.add(@passwordField, c)
    @passwordField.addKeyListener(keyListener)
    
    return panel
  end # mainPanel
  
end
