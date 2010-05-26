#
#  SearchPanel.rb
#  BioCatalogue-Mass-Curator
#
#  Created by Mannie Tagarira on 26/05/2010.
#  Copyright (c) 2010 University Of Manchester, UK. All rights reserved.
#

class SearchPanel < JPanel
  
  attr_reader :searchField
  
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
    self.add(@searchField = JTextField.new, c)
          
    # preview button
    c.gridx = 1
    c.weightx = 1
    searchButton = JButton.new("Search")
    searchButton.addActionListener(BioCatalogueClient.SEARCH)
    self.add(searchButton, c)
  end # initUI
end
