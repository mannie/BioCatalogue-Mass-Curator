#
#  Curation.rb
#  BioCatalogue-Mass-Curator
#
#  Created by Mannie Tagarira on 26/05/2010.
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

module Curation

  def self.generateSpreadsheet(services, saveDir)
    return nil if services.nil? || services.empty? || 
        saveDir.nil? || saveDir.empty?

    # FORMATTING
    Spreadsheet.client_encoding = 'UTF-8'
    @@formats ||= defineSpreadsheetFormatting
    @@heightMultiplier = 1.3
    @@offset ||= 1
    
    # initialise
    filename = "Curation Spreadsheet - #{Time.now.strftime('%Y-%m-%d')}.xls"
    file = File.new(File.join(saveDir, filename), "w+")
    @workbook = Spreadsheet::Workbook.new(file.path)  
    
    @worksheet = @workbook.create_worksheet :name => "Annotate Services"
    
    # create header and set format
    @nextRow = 0

    header = %w{ ID Type Name Descriptions Tags Examples }
    @worksheet.row(@nextRow).concat(header)
    header.size.times { |cell|
      @worksheet.row(@nextRow).set_format(cell, @@formats[:header]) 

      width = case cell
                when 0: 7 # ID
                when 1: 20 # Type
                when 2: 40 # Name
                when 3: 50 # Descriptions
                when 4: 20 # Tags
                when 5: 30 # Examples
              end
      @worksheet.column(cell).width = width
    }
    @worksheet.row(@nextRow).height *= @@heightMultiplier
        
    # loop through services and write to @workbook
    services.each do |id, service|
      next unless service.technology == "SOAP"
      
      success = service.fetchComponents
      LOG.info "#{id} - #{success}"
      next unless success
      
      @nextRow += 1
      writeToSpreadsheet(service)
      puts service.inspect
    end          
    
    # finalise
    @workbook.write(file.path)
    file.close
    
    return file
  end # self.generateSpreadsheet

private

  def self.defineSpreadsheetFormatting
    size = 11
    patt = 1
    
    h = Spreadsheet::Format.new(:size => size + 1, :pattern_fg_color => :grey,
        :pattern => patt, :weight => :bold, :align => :center)
    s = Spreadsheet::Format.new(:size => size, :pattern_fg_color => :magenta,
        :pattern => patt, :weight => :bold)                                 
    op = Spreadsheet::Format.new(:size => size, :pattern_fg_color => :green, 
        :pattern => patt)                                     
    i = Spreadsheet::Format.new(:size => size, :pattern_fg_color => :cyan, 
        :pattern => patt)
    o = Spreadsheet::Format.new(:size => size, :pattern_fg_color => :brown, 
        :pattern => patt)
    
    return { :header => h, 
             :service => s, 
             :operation => op, 
             :input => i, 
             :output => o }        
  end # self.defineSpreadsheetFormatting
  
  def self.writeToSpreadsheet(service)
    # write service row and format
    @worksheet[@nextRow, 0] = service.id
    @worksheet[@nextRow, 1] = "#{service.technology} Service"
    @worksheet[@nextRow, 2] = service.name       
    3.times { |x| @worksheet.row(@nextRow).set_format(x, @@formats[:service]) }
    @worksheet.row(@nextRow).height *= @@heightMultiplier
    
    # iterate over top level components
    @nextRow += 1
    writeServiceComponents(service)
    
    @nextRow += 1
  end # self.writeToSpreadsheet
  
  def self.writeServiceComponents(service)
    service.components.each do |id, component|
      # write operation   
      writeComponentRow(@@formats[:operation], "SOAP Operation", component.name)
              
      # write inputs
      component.inputs.each do |id, name|
        writeComponentRow(@@formats[:input], "SOAP Input", name)
      end # component.inputs.each
      
      # write outputs
      component.outputs.each do |id, name|
        writeComponentRow(@@formats[:output], "SOAP Output", name)
      end # component.outputs.each
    end # service.components.each
  end # self.writeServiceComponents
  
  def self.writeComponentRow(format, type, name)
    @worksheet[@nextRow, 1] = type
    @worksheet[@nextRow, 2] = name
    
    2.times { |x| @worksheet.row(@nextRow).set_format(x + @@offset, format) }
    @worksheet.row(@nextRow).height *= @@heightMultiplier
    
    @nextRow += 1
  end

end # module Curation
