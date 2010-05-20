#
# application_requires.rb
# BioCatalogue-Mass-Curator
#
# Created by Mannie Tagarira on 19/05/2010.
# Copyright 2010 University Of Manchester, UK. All rights reserved.

# ========================================

# Directory Name Constants
APPLICATION_ROOT = File.expand_path(File.join(File.dirname(__FILE__), ".."))

USER_INTERFACE_DIR = File.join(APPLICATION_ROOT, "User-Interface")
EVENT_HANDLERS_DIR = File.join(APPLICATION_ROOT, "Event-Handlers")
RESOURCES_DIR = File.join(APPLICATION_ROOT, "Resources")

# ========================================

# Source Files To Include
UI_SOURCES = %w{ MainWindow.rb MainPanel.rb }
EH_SOURCES = %w{  }
RESOURCES = %w{  }

# ========================================

# INCLUDES

# Core Libraries
require 'java'
require 'rubygems'

# RubyGems

# Java Classes
import java.awt.BorderLayout
import java.awt.FlowLayout

import javax.swing.BoxLayout
import javax.swing.JButton
import javax.swing.JFrame
import javax.swing.JOptionPane
import javax.swing.JPanel
import javax.swing.JLabel

# Application Sources
UI_SOURCES.each { |filename| require File.join(USER_INTERFACE_DIR, filename) }
EH_SOURCES.each { |filename| require File.join(EVENT_HANDLERS_DIR, filename) }
RESOURCES.each { |filename| require File.join(RESOURCES_DIR, filename) }
