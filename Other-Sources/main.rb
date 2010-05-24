#
#  main.rb
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

# Set Up Logging Facilities
require 'logger'
LOG = Logger.new(STDOUT)
# LOG.level = Logger::WARN # DEBUG < INFO < WARN < ERROR < FATAL < UNKNOWN

=begin
%w{ spreadsheet ruby-ole libxml-jruby }.each do |gem|
  # TODO: show in a dialog box?
  if `gem list | grep "#{gem}"`.empty?
    LOG.fatal "The '#{gem}' gem could not be found.  You can install this by running:\n  sudo jruby -S gem install #{gem}"
    exit
  end
end
=end

require File.join(File.dirname(__FILE__), 'application_requires.rb')

mainWindow = MainWindow.new
# selectedServicesWindow = SelectedServicesWindow.new
LOG.warn "SelectedServicesWindow"