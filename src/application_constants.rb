#
#  application_constants.rb
#  BioCatalogue-Mass-Curator
#
#  Created by Mannie Tagarira on 04/06/2010.
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
   along with this program.  If not, see http://www.gnu.org/licenses/gpl.html
=end

# This file defines which files/classes are required to load up the application.
# The XXX_DIR vars are used in some modules in the application.

# ========================================

# Application Directory Names

EVENTS_DIR = File.expand_path(File.join(File.dirname(__FILE__), "events")).freeze
MODELS_DIR = File.expand_path(File.join(File.dirname(__FILE__), "models")).freeze
MODULES_DIR = File.expand_path(File.join(File.dirname(__FILE__), "modules")).freeze
UI_DIR = File.expand_path(File.join(File.dirname(__FILE__), "ui")).freeze

dirPath = File.join(File.dirname(__FILE__), "..", "resources")
dirPath = File.expand_path(dirPath.gsub("file:", "")).freeze
RESOURCES_DIR = dirPath

# ========================================

# Config file

dirLevels = ""
filePath = ''

3.times do |x|
  filePath = File.join(File.dirname(__FILE__), dirLevels, "mass-curator.conf")
  filePath = File.expand_path(filePath.gsub("file:", "")).freeze

  break if File.file?(filePath)
  
  filePath = ''
  dirLevels << "../"
end

CONFIG_FILE_PATH = filePath

# ========================================

# Application Source Files To Include

EVENTS_SRC = %w{ AppCheckBoxListener
                 AppComponentListener.rb
                 AppKeyListener.rb
                 AppWindowListener.rb
                 CredentialsKeyListener.rb
                 GenerateSpreadsheetAction.rb 
                 GoBackAction.rb
                 LoadServicesAction.rb
                 PreviewAction.rb
                 SearchAction.rb
                 ServiceCheckBoxListener.rb
                 UploadSpreadsheetAction.rb }.freeze

MODELS_SRC = %w{ Service.rb
                 ServiceComponent.rb
                 ServiceComponentIO.rb }.freeze

MODULES_SRC = %w{ Application.rb
                  BioCatalogueClient.rb
                  Cache.rb
                  Component.rb
                  JSONUtil.rb
                  LoggerHelper.rb
                  Notification.rb
                  Resource.rb
                  SpreadsheetConstants.rb
                  SpreadsheetGeneration.rb
                  SpreadsheetParsing.rb
                  XMLUtil.rb }.freeze

UI_SRC = %w{ BrowsingStatusPanel.rb
             MainWindow.rb 
             MainPanel.rb
             SearchPanel.rb
             SearchResultsWindow.rb
             ServiceListingPanel.rb
             SearchResultsPanel.rb
             ServiceSelectPanel.rb
             SelectedServicesWindow.rb 
             UploadSpreadsheetPanel.rb }.freeze

# ========================================

# Java Classes To Include
AWT = %w{ BorderLayout
          Color
          Dimension
          FlowLayout 
          GridLayout
          GridBagLayout
          GridBagConstraints
          Insets
          Toolkit }.freeze

AWT_EVENTS = %w{ ActionEvent
                 ActionListener
                 ComponentListener
                 KeyEvent
                 KeyListener
                 WindowListener }.freeze

SWING = %w{ filechooser.FileNameExtensionFilter
            BorderFactory 
            BoxLayout 
            ImageIcon
            JButton 
            JCheckBox
            JDialog
            JFileChooser
            JFrame 
            JLabel 
            JOptionPane 
            JPanel
            JPasswordField
            JScrollPane
            JTextArea
            JTextField
            SwingConstants
            SwingUtilities }.freeze

SWING_EVENTS = %w{ ChangeListener }.freeze

OTHER_CLASSES = %w{ edu.stanford.ejalbert.BrowserLauncher 
                    java.io.FileInputStream                    
                    org.apache.poi.hssf.usermodel.HSSFWorkbook
                    org.apache.poi.hssf.usermodel.HSSFCell }.freeze
