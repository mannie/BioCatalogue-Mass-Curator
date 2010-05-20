#
#  main.rb
#  BioCatalogue-Mass-Curator
#
#  Created by Mannie Tagarira on 19/05/2010.
#  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
#

require File.join(File.dirname(__FILE__), 'application_requires.rb')

window = MainWindow.new

window.setSize(1000, 700)
window.setLocation(300, 150)
window.setDefaultCloseOperation(JFrame::EXIT_ON_CLOSE)

window.visible = true
