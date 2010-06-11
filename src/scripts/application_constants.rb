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
   along with this program.  If not, see http://www.gnu.org/licenses/gpl.html.
=end

# ========================================

# Application Directory Names

APP_ROOT = File.expand_path(
    File.join(File.dirname(__FILE__), "..", "..")).freeze

EVENTS_DIR = File.join(APP_ROOT, "src", "events").freeze
MODELS_DIR = File.join(APP_ROOT, "src", "models").freeze
MODULES_DIR = File.join(APP_ROOT, "src", "modules").freeze
SCRIPTS_DIR = File.join(APP_ROOT, "src", "scripts").freeze
UI_DIR = File.join(APP_ROOT, "src", "ui").freeze

LIB_DIR = File.join(APP_ROOT, "lib").freeze

RESOURCES_DIR = File.join(APP_ROOT, "resources").freeze

# ========================================

# Application Source Files To Include

EVENTS_SRC = %w{ AppComponentListener.rb
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

MODELS_SRC = %w{ BioCatalogueClient.rb
                 Service.rb
                 ServiceComponent.rb
                 ServiceComponentPort.rb }.freeze

MODULES_SRC = %w{ Application.rb
                  Cache.rb
                  Component.rb
                  LoggerHelper.rb
                  Notification.rb
                  Resource.rb
                  SpreadsheetConstants.rb
                  SpreadsheetGeneration.rb
                  SpreadsheetParsing.rb
                  XMLUtils.rb }.freeze

UI_SRC = %w{ BrowsingStatusPanel.rb
             MainWindow.rb 
             MainPanel.rb
             PreviewDialog.rb
             SearchPanel.rb
             SearchResultsWindow.rb
             ServiceListingPanel.rb
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
                    SwingConstants }.freeze

SWING_EVENTS = %w{ ChangeListener }.freeze

OTHER_CLASSES = %w{ edu.stanford.ejalbert.BrowserLauncher }.freeze
