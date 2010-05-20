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
    
    self.setLayout(BorderLayout.new)
    
    contentPane = self.getContentPane
    contentPane.add(JLabel.new("BioCatalogue"), BorderLayout::NORTH)
    contentPane.add(@mainPanel)
  end
end
