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

APP_ROOT = File.expand_path(File.join(File.dirname(__FILE__), "..")).freeze

EVENT_HANDLERS_DIR = File.join(APP_ROOT, "Event-Handlers").freeze
LIBRARIES_DIR = File.join(APP_ROOT, "Libraries").freeze
MODELS_DIR = File.join(APP_ROOT, "Models").freeze
RESOURCES_DIR = File.join(APP_ROOT, "Resources").freeze
USER_INTERFACE_DIR = File.join(APP_ROOT, "User-Interface").freeze

# ========================================

# Application Source Files To Include

EVENT_HANDLERS = %w{ AppWindowListener.rb
                     CheckBoxListener.rb
                     GenerateSpreadsheetAction.rb 
                     GoBackAction.rb
                     LoadServicesAction.rb
                     PreviewAction.rb
                     SearchAction.rb
                     UploadSpreadsheetAction.rb }.freeze

LIBRARIES = %w{ Application.rb
                Cache.rb
                Component.rb
                LoggerHelper.rb
                Notification.rb
                SpreadsheetConstants.rb
                SpreadsheetGeneration.rb
                SpreadsheetParsing.rb
                XMLUtils.rb }.freeze

MODELS = %w{ BioCatalogueClient.rb
             Service.rb
             ServiceComponent.rb
             ServiceComponentPort.rb }.freeze

RESOURCES = %w{  }.freeze

USER_INTERFACE = %w{ BrowsingStatusPanel.rb
                     LoginPanel.rb
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
JAR_ARCHIVES = %w{ BrowserLauncher2-1_3.jar }.freeze

AWT_CLASSES = %w{ BorderLayout
                  Color
                  Dimension
                  FlowLayout 
                  GridLayout
                  GridBagLayout
                  GridBagConstraints
                  Insets
                  Toolkit }.freeze

AWT_EVENTS = %w{ ActionListener
                 WindowListener }.freeze

SWING_CLASSES = %w{ filechooser.FileNameExtensionFilter
                    plaf.basic.BasicArrowButton
                    BorderFactory 
                    BoxLayout 
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

JARS = %w{ BrowserLauncher2-1_3.jar }.freeze

OTHER_CLASSES = %w{ edu.stanford.ejalbert.BrowserLauncher }.freeze
