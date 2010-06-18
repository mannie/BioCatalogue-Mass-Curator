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
   along with this program.  If not, see http://www.gnu.org/licenses/gpl.html
=end

module SpreadsheetConstants
  
  @@columnNumberFor = { :id => 0, 
                        :type => 1, 
                        :name => 2, 
                        :descriptions => 3,
                        :newDescriptions => 4,
                        :tags => 5,
                        :examples => 6 }
  
  def self.column(key)
    @@columnNumberFor[key.to_sym]
  end # self.column
  
  def self.HEIGHT_MULTIPLIER
    1.4 
  end # self.HEIGHT_MULTIPLIER
  
  def self.HEADER
    header = []
    
    @@columnNumberFor.each do |property, cell|
      val = case property
              when :id : "ID"
              when :newDescriptions : "New Descriptions"
              else property.to_s.capitalize
            end
      
      header[cell] = val
    end # each property
    
    return header
  end # self.HEADER

  def self.widthFor(cell)
    case cell
      when @@columnNumberFor[:id]
        7
      when @@columnNumberFor[:type]
        20
      when @@columnNumberFor[:name]
        40
      when @@columnNumberFor[:descriptions], @@columnNumberFor[:newDescriptions]
        70
      when @@columnNumberFor[:tags]
        20 
      when @@columnNumberFor[:examples] 
        30 
    end
  end # self.widthFor
  
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
