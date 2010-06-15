#
#  SpreadsheetGeneration.rb
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
   along with this program.  If not, see http://www.gnu.org/licenses/gpl.html
=end

module SpreadsheetGeneration

  def self.generateSpreadsheet(services, saveDirPath)
    begin
      raise "Invalid arguments" if services.nil? || services.empty? ||
          saveDirPath.nil? || saveDirPath.empty?

      # FORMATTING
      Spreadsheet.client_encoding = 'UTF-8'
      @@formats ||= SpreadsheetConstants.defineSpreadsheetFormatting
      @@offset ||= 1
      
      # initialise
      filename = "Curation Spreadsheet (#{Time.now.strftime('%Y-%m-%d')} at " 
      filename += "#{Time.now.strftime('%H%M')}).xls"
      
      file = File.new(File.join(saveDirPath, filename), "w+")
      @workbook = Spreadsheet::Workbook.new(file.path)  
      
      @worksheet = @workbook.create_worksheet :name => "Annotate Services"
      
      # create header and set format
      @nextRow = 0
      @worksheet.row(@nextRow).concat(SpreadsheetConstants.HEADER)
      SpreadsheetConstants.HEADER.size.times { |cell|
        @worksheet.row(@nextRow).set_format(cell, @@formats[:header]) 
        @worksheet.column(cell).width = SpreadsheetConstants.widthForCell(cell)
      }
      @worksheet.row(@nextRow).height *= SpreadsheetConstants.HEIGHT_MULTIPLIER
          
      # loop through services and write to @workbook
      services.each do |id, service|
        next unless service.technology == "SOAP"
        
        success = service.fetchComponents
        next unless success
        
        @nextRow += 1
        writeToSpreadsheet(service)
      end          
      
      # finalise
      @workbook.write(file.path)
      file.close
    
      return file
    rescue Exception => ex
      log('e', ex)
      return nil
    end # begin rescue
  end # self.generateSpreadsheet

private

  def self.writeToSpreadsheet(service)
    # write service row and format
    @worksheet[@nextRow, 0] = service.id
    @worksheet[@nextRow, 1] = "#{service.technology} Service"
    @worksheet[@nextRow, 2] = service.name
    @worksheet[@nextRow, 3] = service.description
    3.times { |x| @worksheet.row(@nextRow).set_format(x, @@formats[:service]) }
    @worksheet.row(@nextRow).height *= SpreadsheetConstants.HEIGHT_MULTIPLIER
    
    # iterate over top level components
    @nextRow += 1
    writeServiceComponents(service)
  end # self.writeToSpreadsheet
  
  def self.writeServiceComponents(service)
    service.components.each do |id, component|
      # write operation   
      writeComponentRow(@@formats[:operation], "SOAP Operation", id,
          component.name, component.description)
              
      # write inputs
      component.inputs.each do |id, input|
        writeComponentRow(@@formats[:input], "SOAP Input", id,
            input.name, input.description)
      end # component.inputs.each
      
      # write outputs
      component.outputs.each do |id, output|
        writeComponentRow(@@formats[:output], "SOAP Output", id,
            output.name, output.description)
      end # component.outputs.each
    end # service.components.each
  end # self.writeServiceComponents
  
  def self.writeComponentRow(format, type, id, name, description)
    @worksheet[@nextRow, 0] = id
    @worksheet.row(@nextRow).set_format(0, @@formats[:gray])

    @worksheet[@nextRow, 1] = type
    @worksheet[@nextRow, 2] = name
    @worksheet[@nextRow, 3] = description
        
    2.times { |x| @worksheet.row(@nextRow).set_format(x + @@offset, format) }
    @worksheet.row(@nextRow).height *= SpreadsheetConstants.HEIGHT_MULTIPLIER
    
    @nextRow += 1
  end

end # module SpreadsheetGeneration
