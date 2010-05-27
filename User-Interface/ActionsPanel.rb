#
#  ActionsPanel.rb
#  BioCatalogue-Mass-Curator
#
#  Created by Mannie Tagarira on 27/05/2010.
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

class ActionsPanel < JPanel

  attr_reader :exportButton

  attr_accessor :currentPage, :pageCount

  @@lastLabelUsed = nil
    
  def initialize
    super()
    initUI
    
    @currentPage, @pageCount = -1, -1
    
    return self
  end # initialize
  
  def initUI
    buttonPanel = JPanel.new
    buttonPanel.setLayout(GridLayout.new)
    
    backButton = JButton.new("Go Back")
    backButton.addActionListener(GoBackAction.new(self))
    buttonPanel.add(backButton)

    @exportButton = JButton.new("Export")
    @exportButton.addActionListener(GenerateSpreadsheetAction.new(self))
    buttonPanel.add(@exportButton)
    
    self.add(buttonPanel)
    
    refresh
  end

  def refresh
    self.setVisible(false)
    
    self.remove(@@lastLabelUsed) if @@lastLabelUsed
    @@lastLabelUsed = JLabel.new("Page #{@currentPage} of #{@pageCount}")
    self.add(@@lastLabelUsed)

    self.setVisible(true)
  end
  
end
