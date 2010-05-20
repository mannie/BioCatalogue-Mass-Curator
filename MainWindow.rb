#
#  MainWindow.rb
#  BioCatalogue-Mass-Curator
#
#  Created by Mannie Tagarira on 19/05/2010.
#  Copyright (c) 2010 University Of Manchester, UK. All rights reserved.
#

class MainWindow < JFrame
  
  def initialize(title="BioCatalogue Mass Curator")
    super(title)

    initUI
  end
  
private

  def initUI
    @mainPanel = MainPanel.new
    @mainPanel.setLayout(BorderLayout.new)

    buttonPanel = JPanel.new
    buttonPanel.setLayout(FlowLayout.new)
    buttonPanel.add(@downloadButton = JButton.new("Download A Spreadsheet"))
    buttonPanel.add(@uploadButton = JButton.new("Upload A Spreadsheet"))
    
    @mainPanel.add(buttonPanel)

    self.getContentPane.add(@mainPanel)
  end
end
