#
# application_requires.rb
# BioCatalogue-Mass-Curator
#
# Created by Mannie Tagarira on 19/05/2010.
# Copyright 2010 University Of Manchester, UK. All rights reserved.

# Java Core
require 'java'

# Java Classes
JButton = javax.swing.JButton
JFrame = javax.swing.JFrame
JOptionPane = javax.swing.JOptionPane
JPanel = javax.swing.JPanel
BorderLayout = java.awt.BorderLayout
FlowLayout = java.awt.FlowLayout

# Application Classes
RUBY_SOURCES = %w{ MainWindow MainPanel }

RUBY_SOURCES.each { |f| require File.join(File.dirname(__FILE__), "#{f}.rb") }