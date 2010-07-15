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
  
  CATEGORIES = {}
  
  PROPERTY_COLUMN = { :id => 0, 
                      :type => 1, 
                      :name => 2, 
                      :descriptions => 3,
                      :newDescriptions => 4,
                      :tags => 5,
                      :examples => 6, :documentationURLs => 6,
                      :dataFormats => 7, :licenses => 7,
                      :contactInfo => 8,
                      :cost => 9,
                      :publications => 10,
                      :citations => 11,
                      :usageConditions => 12,
                      :categories => 13}.freeze
  
  SERVICE_HEADER_PROPERTIES = [ :id, :type, :name, :descriptions,
                                :newDescriptions, :tags, :documentationURLs, 
                                :licenses, :contactInfo, :cost, :publications, 
                                :citations, :usageConditions, :categories ].freeze

  COMPONENT_HEADER_PROPERTIES = [ :id, :type, :name, :descriptions, 
                                  :newDescriptions, :tags, :examples, 
                                  :dataFormats ].freeze
  
  
  
  def self.column(key)
    PROPERTY_COLUMN[key.to_sym]
  end # self.column
  
  def self.HEIGHT_MULTIPLIER
    1.4 
  end # self.HEIGHT_MULTIPLIER
  
  def self.SERVICE_HEADER
    header = []
        
    SERVICE_HEADER_PROPERTIES.each do |property|
      val = case property              
              when :id : "ID"
              when :descriptions : "Existing Descriptions"
              when :newDescriptions : "New Descriptions"
              when :documentationURLs : "Documentation URLs"
              when :contactInfo : "Contact Info"
              when :usageConditions : "Usage Conditions"
              else property.to_s.capitalize
            end
      
      header[PROPERTY_COLUMN[property]] = val
    end # each property
    
    return header
  end # self.COMPONENT_HEADER
  
  def self.COMPONENT_HEADER
    header = []
    
    COMPONENT_HEADER_PROPERTIES.each do |property|
      val = case property              
              when :id : "ID"
              when :descriptions : "Existing Descriptions"
              when :newDescriptions : "New Descriptions"
              when :dataFormats : "Data Formats"
              else property.to_s.capitalize
            end
      
      header[PROPERTY_COLUMN[property]] = val
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
  
  def self.categoryID(category)
    self.getCategoriesFromHost if CATEGORIES.empty?
    return CATEGORIES[category]
  end
  
  def self.defineSpreadsheetFormatting
    size = 11
    patt = 1
    
    h = Spreadsheet::Format.new(:size => size + 1, :pattern_fg_color => :grey,
                                :pattern => patt, :weight => :bold, 
                                :align => :center, :color => :white)
                                
    s = Spreadsheet::Format.new(:size => size, :pattern_fg_color => :magenta,
                                :pattern => patt, :align => :justify)
                                
    op = Spreadsheet::Format.new(:size => size, :pattern_fg_color => :yellow, 
                                 :pattern => patt, :align => :justify)
                                                              
    i = Spreadsheet::Format.new(:size => size, :pattern_fg_color => :cyan, 
                                :pattern => patt, :align => :justify)
                                
    o = Spreadsheet::Format.new(:size => size, :pattern_fg_color => :lime, 
                                :pattern => patt, :align => :justify)
                                
    g = Spreadsheet::Format.new(:size => size - 1, :color => :gray, 
                                :align => :justify)
    
    n = Spreadsheet::Format.new(:size => size, :pattern_fg_color => :silver, 
                                :pattern => patt, :align => :justify)

    m = Spreadsheet::Format.new(:size => size, :align => :justify)
    
    return { :header => h, 
             :service => s, 
             :operation => op, 
             :input => i, 
             :output => o,
             :gray => g,
             :notAllowed => n,
             :merged => m }
  end # self.defineSpreadsheetFormatting
  
private

  def self.getCategoriesFromHost
    begin      
      categoriesForPage = JSONUtil.paginatedCollection("categories", 
          BioCatalogueClient.HOSTNAME)

      categoriesForPage.each do |page, categories|
        categories.each { |category|
          category_id = category['category']['self'].split('/')[-1]
          CATEGORIES.merge!(cat['category']['name'] => category_id)
        } # categories.each
      end # categoriesForPage.each

      return requestedCategories.uniq.clone
    rescue Exception => ex
      log('e', ex)
    end # begin rescue
  end # self.getCategoriesFromHost

end # module SpreadsheetConstants
