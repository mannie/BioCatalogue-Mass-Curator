#
#  SearchPanel.rb
#  BioCatalogue-Mass-Curator
#
#  Created by Mannie Tagarira on 26/05/2010.
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

class SearchPanel < JPanel
  
  attr_reader :searchField, :searchButton
  
  def initialize
    super()
    initUI
    return self
  end # initialize
  
  def initUI
    self.setLayout(GridBagLayout.new)    
      
    # default constraints
    c = GridBagConstraints.new
    c.fill = GridBagConstraints::HORIZONTAL
    c.anchor = GridBagConstraints::EAST

    # text field
    c.gridx = 0
    c.weightx = 50
    self.add(@searchField = JTextField.new("emboss"), c)
          
    # preview button
    c.gridx = 1
    c.weightx = 1
    @searchButton = JButton.new("Search")
    @searchButton.addActionListener(BioCatalogueClient.SEARCH)
    self.add(@searchButton, c)
  end # initUI
end
