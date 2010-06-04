#
#  SpreadsheetConstants.rb
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

module SpreadsheetConstants

  def self.HEIGHT_MULTIPLIER
    1.4 
  end # self.HEIGHT_MULTIPLIER
  
  def self.HEADER
    %w{ ID Type Name Description Tags Examples }
  end # self.HEADER

  def self.widthForCell(cell)
    case cell
      when 0: 7 # ID
      when 1: 20 # Type
      when 2: 40 # Name
      when 3: 70 # Description
      when 4: 20 # Tags
      when 5: 30 # Examples
    end
  end # self.widthForCell
  
  def self.defineSpreadsheetFormatting
    size = 11
    patt = 1
    
    h = Spreadsheet::Format.new(:size => size + 1, :pattern_fg_color => :grey,
        :pattern => patt, :weight => :bold, :align => :center)
    s = Spreadsheet::Format.new(:size => size, :pattern_fg_color => :magenta,
        :pattern => patt, :weight => :bold)                                 
    op = Spreadsheet::Format.new(:size => size, :pattern_fg_color => :yellow, 
        :pattern => patt)                                     
    i = Spreadsheet::Format.new(:size => size, :pattern_fg_color => :cyan, 
        :pattern => patt)
    o = Spreadsheet::Format.new(:size => size, :pattern_fg_color => :lime, 
        :pattern => patt)
    g = Spreadsheet::Format.new(:size => size - 1, :color => :gray, 
        :locked => true, :hidden => true)
        
    return { :header => h, 
             :service => s, 
             :operation => op, 
             :input => i, 
             :output => o,
             :gray => g }        
  end # self.defineSpreadsheetFormatting
  
end # module SpreadsheetConstants
