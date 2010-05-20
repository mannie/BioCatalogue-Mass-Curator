#
#  MainPanel.rb
#  BioCatalogue-Mass-Curator
#
#  Created by Mannie Tagarira on 19/05/2010.
#  Copyright (c) 2010 University Of Manchester, UK. All rights reserved.
#

class MainPanel < JPanel
    
  def initialize
    super
    
    initUI
  end
  
private

  def initUI
    self.setLayout(BorderLayout.new)

    buttonPanel = JPanel.new
    buttonPanel.add(@downloadButton = JButton.new("Download A Spreadsheet"))
    buttonPanel.add(@uploadButton = JButton.new("Upload A Spreadsheet"))
    
    self.add(buttonPanel)

  end
end
