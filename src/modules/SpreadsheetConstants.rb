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
  
  PROPERTY_COLUMN = { :id => 0, 
                      :type => 1, 
                      :name => 2, 
                      :descriptions => 3,
                      :newDescriptions => 4,
                      :tags => 5,
                      :examples => 6, :documentationURLs => 6,
                      :dataFormat => 7, :licenses => 7,
                      :contactInfo => 8,
                      :cost => 9,
                      :publications => 10,
                      :citations => 11,
                      :usageConditions => 12}.freeze
  
  SERVICE_HEADER_PROPERTIES = [ :id, :type, :name, :descriptions, 
                                :newDescriptions, :tags, :documentationURLs, 
                                :licenses, :contactInfo, :cost, :publications, 
                                :citations, :usageConditions ].freeze

  COMPONENT_HEADER_PROPERTIES = [ :id, :type, :name, :descriptions, 
                                  :newDescriptions, :tags, :examples, 
                                  :dataFormat ].freeze
  
  def self.column(key)
    PROPERTY_COLUMN[key.to_sym]
  end # self.column
  
  def self.HEIGHT_MULTIPLIER
    1.4 
  end # self.HEIGHT_MULTIPLIER
  
  def self.SERVICE_HEADER
    header = []
    
    SERVICE_HEADER_PROPERTIES.size.times do |cell|
      val = case SERVICE_HEADER_PROPERTIES[cell]
              when :id : "ID"
              when :descriptions : "Existing Descriptions"
              when :newDescriptions : "New Descriptions"
              when :documentationURLs : "Documentation URLs"
              when :contactInfo : "Contact Info"
              when :usageConditions : "Usage Conditions"
              else SERVICE_HEADER_PROPERTIES[cell].to_s.capitalize
            end
      
      header[cell] = val
    end # each property
    
    return header
  end # self.COMPONENT_HEADER
  
  def self.COMPONENT_HEADER
    header = []
    
    COMPONENT_HEADER_PROPERTIES.size.times do |cell|
      val = case COMPONENT_HEADER_PROPERTIES[cell]
              when :id : "ID"
              when :descriptions : "Existing Descriptions"
              when :newDescriptions : "New Descriptions"
              when :dataFormat : "Data Formats"
              else COMPONENT_HEADER_PROPERTIES[cell].to_s.capitalize
            end
      
      header[cell] = val
    end # each property
    
    return header
  end # self.COMPONENT_HEADER

  def self.widthFor(cell)
    case cell
      when PROPERTY_COLUMN[:id] : 7
      when PROPERTY_COLUMN[:name] : 40
      when PROPERTY_COLUMN[:descriptions], PROPERTY_COLUMN[:newDescriptions] : 50
      when PROPERTY_COLUMN[:examples] : 30
      else 20
    end
  end # self.widthFor
  
  def self.defineSpreadsheetFormatting
    size = 11
    patt = 1
    
    h = Spreadsheet::Format.new(:size => size + 1, :pattern_fg_color => :grey,
                                :pattern => patt, :weight => :bold, 
                                :align => :center)
    s = Spreadsheet::Format.new(:size => size, :pattern_fg_color => :magenta,
                                :pattern => patt)                                 
    op = Spreadsheet::Format.new(:size => size, :pattern_fg_color => :yellow, 
                                 :pattern => patt)                                     
    i = Spreadsheet::Format.new(:size => size, :pattern_fg_color => :cyan, 
                                :pattern => patt)
    o = Spreadsheet::Format.new(:size => size, :pattern_fg_color => :lime, 
                                :pattern => patt)
    g = Spreadsheet::Format.new(:size => size - 1, :color => :gray)
    n = Spreadsheet::Format.new(:pattern_fg_color => :grey, :pattern => patt)
        
    return { :header => h, 
             :service => s, 
             :operation => op, 
             :input => i, 
             :output => o,
             :gray => g,
             :notAllowed => n }
  end # self.defineSpreadsheetFormatting
  
end # module SpreadsheetConstants
