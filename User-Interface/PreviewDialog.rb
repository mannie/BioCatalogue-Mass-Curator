#
#  PreviewDialog.rb
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

class PreviewDialog < JDialog
  
  def initialize(service, parent, title)
    
    super(parent, title, true)
    
    @service = service if service.class == Service
    @parent = parent
    
    initUI
    
    return self
  end
  
private
  
  def initUI
    self.getContentPane.add(JLabel.new(@service.to_s))
        
    self.setSize(300, 500)
    self.setDefaultCloseOperation(JFrame::DISPOSE_ON_CLOSE)
    
    Component.centerToParent(self, @parent)
    
    log('w', nil, "Implement fetchMoreInformation for service")
    
    self.setVisible(true)
  end
  
end
