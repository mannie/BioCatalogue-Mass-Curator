#
#  AppWindowListener.rb
#  BioCatalogue-Mass-Curator
#
#  Created by Mannie Tagarira on 21/05/2010.
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

class AppWindowListener
  java_implements WindowListener

  def windowActivated(event)
  end # windowActivated
  
  def windowClosed(event)
  end # windowClosed
  
  def windowClosing(event)
    yesNo = JOptionPane.showConfirmDialog(event.getSource,
        "Are you sure you want to close this application?",
        "Quit?", JOptionPane::YES_NO_OPTION)
        
    if yesNo == JOptionPane::YES_OPTION
      event.getSource.dispose
      LOGGER.close
      java.lang.System::exit(0)
    end
  end # windowClosing
  
  def windowDeactivated(event)
  end # windowDeactivated
  
  def windowDeiconified(event)
  end # windowDeiconified
  
  def windowIconified(event)
  end # windowIconified
  
  def windowOpened(event)
  end # windowOpened
  
end
