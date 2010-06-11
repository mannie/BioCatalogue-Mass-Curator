#!/bin/sh

# run.sh
# BioCatalogue-Mass-Curator
#
# Created by Mannie Tagarira on 27/05/2010.
# Copyright (c) 2010 University of Manchester, UK.

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see http://www.gnu.org/licenses/gpl.html.

# ========================================

CURRENT_DIR=$(dirname $0)

BOOTSTRAP=$CURRENT_DIR/BioCatalogue-Mass-Curator.jar

JSON=$CURRENT_DIR/lib/json-jruby.jar
SPREADSHEET=$CURRENT_DIR/lib/spreadsheet.jar
LIBXML=$CURRENT_DIR/lib/libxml-jruby.jar
LAUNCHER=$CURRENT_DIR/lib/BrowserLauncher2-1_3.jar

java -jar $BOOTSTRAP -r$LIBXML -r$SPREADSHEET -r$JSON -r$LAUNCHER

exit 0
