#
#  application_requires.rb
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

# ========================================

# Directory Name Constants
APPLICATION_ROOT = File.expand_path(File.join(File.dirname(__FILE__), ".."))

USER_INTERFACE_DIR = File.join(APPLICATION_ROOT, "User-Interface")
EVENT_HANDLERS_DIR = File.join(APPLICATION_ROOT, "Event-Handlers")
RESOURCES_DIR = File.join(APPLICATION_ROOT, "Resources")

# ========================================

# Source Files To Include
UI_SOURCES = %w{ LoginPanel.rb
                 MainWindow.rb 
                 MainPanel.rb 
                 ServiceSelectPanel.rb 
                 SpreadsheetUploadPanel.rb }
                 
EH_SOURCES = %w{ DoLoginAction.rb
                 DownloadSpreadsheetAction.rb 
                 GoBackAction.rb 
                 UploadSpreadsheetAction.rb }

RESOURCES = %w{  }

# Java Classes To Include
AWT_CLASSES = %w{ BorderLayout 
                  event.ActionListener 
                  FlowLayout 
                  GridBagLayout
                  GridBagConstraints
                  Insets }

SWING_CLASSES = %w{ BorderFactory 
                    BoxLayout 
                    JButton 
                    JCheckBox
                    JFrame 
                    JLabel 
                    JOptionPane 
                    JPanel
                    JPasswordField
                    JTextField }

# ========================================

# Core Libraries
require 'java'

# RubyGems
require 'net/http'
require 'uri'

# Java Classes
AWT_CLASSES.each { |awt| import "java.awt." << awt }
SWING_CLASSES.each { |swing| import "javax.swing." << swing }

# Application Sources
UI_SOURCES.each { |filename| require File.join(USER_INTERFACE_DIR, filename) }
EH_SOURCES.each { |filename| require File.join(EVENT_HANDLERS_DIR, filename) }
RESOURCES.each { |filename| require File.join(RESOURCES_DIR, filename) }
