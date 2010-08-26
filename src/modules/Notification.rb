#
#  Notification.rb
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

module Notification
  
  def self.errorDialog(msg, title="Error")
    JOptionPane.showMessageDialog(MAIN_WINDOW, msg, title, JOptionPane::ERROR_MESSAGE)
  end # self.errorDialog
  
  def self.informationDialog(msg, title="Information")
    JOptionPane.showMessageDialog(MAIN_WINDOW, msg, title, JOptionPane::INFORMATION_MESSAGE)
  end # self.informationDialog
  
end # module Notification
