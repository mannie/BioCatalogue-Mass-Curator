#
#  LoggerHelper.rb
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

require 'logger'

LOGGER ||= Logger.new('mass-curator.log', 'weekly')

# --------------------

def log(level, exception, msg=nil)
  begin
    raise "Invalid parameters passed to logger" if level.nil? || level.empty? ||
        (exception.nil? && msg.nil?)
    
    msg = "#{exception.class.name} - #{exception.message}\n" << 
        exception.backtrace.join("\n") if msg.nil?
    
    level = 'U' unless %w{ DEBUG INFO WARN ERROR FATAL }.include?(level.upcase)
    
    case level
      when 'D': LOGGER.debug msg
      when 'I': LOGGER.info msg
      when 'W': LOGGER.warn msg
      when 'E': LOGGER.error msg
      when 'F': LOGGER.fatal msg; LOGGER.close
      else LOGGER.unknown msg
    end # case

  rescue Exception => ex
    LOGGER.error "#{ex.class.name} - #{ex.message}\n" << ex.backtrace.join("\n")
  end
end # self.log
