#
#  AppKeyListener.rb
#  BioCatalogue-Mass-Curator
#
#  Created by Mannie Tagarira on 10/06/2010.
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

# This is a generic key listener for the application

# ========================================

class AppKeyListener
  java_implements KeyListener
 
  def keyPressed(event) 
  end # keyPressed
 
  def keyReleased(event) 
  end # keyReleased
 
  def keyTyped(event)    
    if Component.searchField.getText.strip.empty?
      Component.searchButton.setEnabled(false)
      return
    else
      Component.searchButton.setEnabled(true)
    end
    
    case event.getKeyChar
      when KeyEvent::VK_ENTER
        @@searchAction ||= SearchAction.new(Component.searchPanel, 1)
        @@searchAction.actionPerformed(ActionEvent.new(Component.searchButton, 0, ''))
    end
  end # keyTyped

end # AppKeyListener