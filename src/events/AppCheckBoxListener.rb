#
#  AppCheckBoxListener.rb
#  BioCatalogue-Mass-Curator
#
#  Created by Mannie Tagarira on 17/06/2010.
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

# This is a generic checkbox listener for the application.
# Also see ServiceCheckBoxListener.

# ========================================

class AppCheckBoxListener
  java_implements ChangeListener

  # ACCEPTS: the container of the button
  # RETURNS: self
  def initialize(container)
    super()
    
    @buttonContainer = container
        
    return self
  end # initialize

# --------------------
  
  def stateChanged(event)
    if @buttonContainer.class==UploadSpreadsheetPanel
      Thread.new("Storing configurations...") {
        if event.getSource.isSelected
          user = @buttonContainer.usernameField.getText.strip
          pass = @buttonContainer.passwordField.getText.strip

          BioCatalogueClient.setCurrentUser(user, pass)
        else
          BioCatalogueClient.setCurrentUser('', '')
        end
        
        Application.storeCredentials(event.getSource.isSelected)
        Application.writeConfigFile
      }
    end # remember me checkbox
  end # stateChanged
  
end # AppCheckBoxListener
