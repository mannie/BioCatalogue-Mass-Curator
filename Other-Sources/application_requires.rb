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

# Application Constants

# Directory Names
APP_ROOT = File.expand_path(File.join(File.dirname(__FILE__), "..")).freeze

USER_INTERFACE_DIR = File.join(APP_ROOT, "User-Interface").freeze
EVENT_HANDLERS_DIR = File.join(APP_ROOT, "Event-Handlers").freeze
MODELS_DIR = File.join(APP_ROOT, "Models").freeze
RESOURCES_DIR = File.join(APP_ROOT, "Resources").freeze

# ========================================

# Source Files To Include
USER_INTERFACE = %w{ LoginPanel.rb
                     MainWindow.rb 
                     MainPanel.rb 
                     ServiceSelectPanel.rb 
                     SpreadsheetUploadPanel.rb }.freeze
                 
EVENT_HANDLERS = %w{ DoLoginAction.rb
                     DownloadSpreadsheetAction.rb 
                     GoBackAction.rb
                     PreviewAction.rb 
                     UploadSpreadsheetAction.rb }.freeze

MODELS = %w{ BioCatalogueClient.rb
             Service.rb }.freeze

RESOURCES = %w{  }.freeze

# Java Classes To Include
AWT_CLASSES = %w{ BorderLayout 
                  event.ActionListener 
                  FlowLayout 
                  GridBagLayout
                  GridBagConstraints
                  Insets }.freeze

SWING_CLASSES = %w{ BorderFactory 
                    BoxLayout 
                    JButton 
                    JCheckBox
                    JFrame 
                    JLabel 
                    JOptionPane 
                    JPanel
                    JPasswordField
                    JTextField }.freeze

# ========================================

# Require Java Core Libraries
require 'java'

# Import Java Classes
AWT_CLASSES.each { |awt| import "java.awt." << awt }
SWING_CLASSES.each { |swing| import "javax.swing." << swing }

# Require Ruby Gems
require 'net/http'
require 'uri'

# Require Application Sources
USER_INTERFACE.each { |fname| require File.join(USER_INTERFACE_DIR, fname) }
EVENT_HANDLERS.each { |fname| require File.join(EVENT_HANDLERS_DIR, fname) }
MODELS.each { |fname| require File.join(MODELS_DIR, fname) }
RESOURCES.each { |fname| require File.join(RESOURCES_DIR, fname) }
