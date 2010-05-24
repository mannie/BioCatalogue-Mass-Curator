#
#  MainWindow.rb
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
   along with this program.  If not, see http://www.gnu.org/licenses/gpl.html.
=end

class MainWindow < JFrame
  
  def initialize(title="BioCatalogue Mass Curator")
    super(title)
    initUI    
    
    @@CONTENT_PANE ||= self.getContentPane
    @@MAIN_PANEL ||= @mainPanel
    
    addWindowListener(AppWindowListener.new)
    return self
  end # initialize
  
# --------------------
  
  def self.CONTENT_PANE
    @@CONTENT_PANE
  end # self.CONTENT_PANE
  
  def self.MAIN_PANEL
    @@MAIN_PANEL
  end # self.MAIN_PANEL
    
private

  def initUI
    @mainPanel = MainPanel.new

    self.setLayout(BorderLayout.new)
    self.getContentPane.add(@mainPanel)
    
    self.setSize(800, 500)
    self.setLocation(400, 150)
    self.setDefaultCloseOperation(JFrame::EXIT_ON_CLOSE)

    self.visible = true
  end # initUI
  
end
