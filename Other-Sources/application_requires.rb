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

# Require Java Core Libraries
require 'java'

# Import Java Classes
AWT_CLASSES.each { |awt| import "java.awt." << awt }
AWT_EVENTS.each { |event| import "java.awt.event." << event }

SWING_CLASSES.each { |swing| import "javax.swing." << swing }
SWING_EVENTS.each { |event| import "javax.swing.event." << event }

MISC_CLASSES.each { |misc| import misc }

# Require Ruby Gems
require 'rubygems'

require 'open-uri'
require 'net/http'

require 'spreadsheet'

require 'xml/libxml'
require 'json/ext'

# Require Application Sources
EVENT_HANDLERS.each { |fname| require File.join(EVENT_HANDLERS_DIR, fname) }
LIBRARIES.each { |fname| require File.join(LIBRARIES_DIR, fname) }
MODELS.each { |fname| require File.join(MODELS_DIR, fname) }
RESOURCES.each { |fname| require File.join(RESOURCES_DIR, fname) }
USER_INTERFACE.each { |fname| require File.join(USER_INTERFACE_DIR, fname) }
