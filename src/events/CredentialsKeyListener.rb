#
#  CredentialsKeyListener.rb
#  BioCatalogue-Mass-Curator
#
#  Created by Mannie Tagarira on 11/06/2010.
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

# This is a specific key listener for handling logins via key presses.

# ========================================

class CredentialsKeyListener
  java_implements KeyListener
 
  # ACCEPTS: the container of the button
  # RETURNS: self
  def initialize(container)
    super()
    
    @buttonContainer = container
        
    return self
  end # initialize

# --------------------

  def keyPressed(event) 
  end # keyPressed
 
  def keyReleased(event) 
  end # keyReleased
 
  def keyTyped(event)
    return unless @buttonContainer.class==UploadSpreadsheetPanel
    
    user = @buttonContainer.usernameField.getText.strip
    pass = @buttonContainer.passwordField.getText.strip
    
    if user.empty? || pass.empty? || !@buttonContainer.spreadsheetSpecified
      @buttonContainer.uploadSpreadsheetButton.setEnabled(false)
      return
    else
      @buttonContainer.uploadSpreadsheetButton.setEnabled(true)
    end
    
    case event.getKeyChar
      when KeyEvent::VK_ENTER
        actionEvent = ActionEvent.new(@buttonContainer.uploadSpreadsheetButton, 0, '')
        @buttonContainer.uploadSpreadsheetAction.actionPerformed(actionEvent)
    end
  end # keyTyped

end # CredentialsKeyListener
