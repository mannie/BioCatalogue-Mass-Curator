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

# Import Java Libraries
AWT.each { |awt| java_import "java.awt." << awt }
AWT_EVENTS.each { |event| java_import "java.awt.event." << event }

SWING.each { |swing| java_import "javax.swing." << swing }
SWING_EVENTS.each { |event| java_import "javax.swing.event." << event }

OTHER_CLASSES.each { |library| java_import library }

# Require Ruby Gems
require 'rubygems'

require 'open-uri'
require 'net/http'

require 'spreadsheet'

require 'xml/libxml'
require 'json/ext'

# Require Application Sources
EVENTS_SRC.each { |src| require File.join(EVENTS_DIR, src) }
MODELS_SRC.each { |src| require File.join(MODELS_DIR, src) }
MODULES_SRC.each { |src| require File.join(MODULES_DIR, src) }
UI_SRC.each { |src| require File.join(UI_DIR, src) }