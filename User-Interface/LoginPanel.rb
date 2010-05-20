#
#  LoginPanel.rb
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

class LoginPanel < JPanel

  def initialize
    super()
    initUI
  end # initialize
  
private
  
  def initUI
    self.setLayout(BorderLayout.new)
    self.add(loginBox)
    self.add(backButton = JButton.new("Back"), BorderLayout::SOUTH)
    
    backButton.addActionListener(GoBackAction.new(self))    
  end # initUI

  def loginBox
    loginBox = JPanel.new
    loginBox.setBorder(BorderFactory.createCompoundBorder(BorderFactory.createEtchedBorder(), BorderFactory.createEmptyBorder(10, 10, 10, 10)))

    loginBox.setLayout(GridBagLayout.new)

    # set constraints
    c = GridBagConstraints.new
    c.gridwidth = GridBagConstraints::REMAINDER
    c.insets = (insets = Insets.new(0, 0, 15, 0))
    c.gridx = 0
    c.gridy = 0

    # "Login to BioCat" label
    loginLabel = JLabel.new("<html><b>Log in to BioCatalogue</b></html>")
    loginLabel.setFont(loginLabel.getFont().deriveFont(13.0))
    loginBox.add(loginLabel, c);

    # update constraints
    c.weightx = 1
    c.gridwidth = 1
    c.anchor = GridBagConstraints::LINE_START
    c.insets.set(0, 0, 3, 0)
    c.ipadx = 10

    # username label 
    c.gridy += 1
    usernameLabel = JLabel.new("BioCatalogue Username:")
    usernameLabel.setLabelFor(usernameField = JTextField.new(20))
    loginBox.add(usernameLabel, c)
    
    # username field
    c.gridx = 1
    loginBox.add(usernameField, c)

    # password label
    c.gridy+= 1
    c.gridx = 0
    passwordLabel = JLabel.new("BioCatalogue Password:")
    passwordLabel.setLabelFor(passwordField = JPasswordField.new(20))
    loginBox.add(passwordLabel, c)
    
    # password field
    c.gridx = 1
    loginBox.add(passwordField, c)

    # remember me checkbox and label
    c.gridy += 1
    c.insets.set(25, 0, 2, 0)
    rememberMeCheckBox = JCheckBox.new("Remember me")
    rememberMeCheckBox.setBorder(BorderFactory.createEmptyBorder())
    loginBox.add(rememberMeCheckBox, c)

    # login button
    c.gridy += 1
    c.gridx = 0
    c.anchor = GridBagConstraints::CENTER
    c.gridwidth = GridBagConstraints::REMAINDER
    c.fill = GridBagConstraints::HORIZONTAL
    c.insets.set(10, 0, 0, 0)
    loginButton = JButton.new("Login")
    loginButton.addActionListener(
      DoLoginAction.new(usernameField, passwordField, rememberMeCheckBox))
    loginBox.add(loginButton, c)

    return loginBox
  end # loginBox

end