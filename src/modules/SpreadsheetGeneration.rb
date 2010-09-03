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
      raise "Invalid arguments" if services.nil? || services.empty? || saveDirPath.nil? || saveDirPath.empty?

      # FORMATTING
      Spreadsheet.client_encoding = 'UTF-8'
      @@formats ||= SpreadsheetConstants.defineSpreadsheetFormatting
      @@offset ||= 1 # the number of cells to skip before applying formatting
      
      # initialise
      filename = "Curation Spreadsheet (#{Time.now.strftime('%Y-%m-%d')} at #{Time.now.strftime('%H%M')}).xls" 
      
      @file = File.new(File.join(saveDirPath, filename), "w+")
      @workbook = Spreadsheet::Workbook.new(@file.path)  

      # write worksheet containing help text
      if CONFIG['spreadsheet']['include-help'].to_s.downcase=="true"
        @worksheet = @workbook.create_worksheet :name => "HELP"

        # write help text
        @nextRow = 0

        @worksheet[@nextRow, 0] = "HELP"
        @worksheet.column(0).width = 150
        @worksheet.row(@nextRow).set_format(0, @@formats[:header])
        
        Resource.helpTextArray.each { |content|
          @nextRow += 1
          @worksheet[@nextRow, 0] = content

          @worksheet.row(@nextRow).set_format(0, @@formats[:merged])
        
          @worksheet.row(@nextRow).height *= SpreadsheetConstants::HEIGHT_MULTIPLIER          
        }

      end
      
      # loop through services and write to @workbook
      services.each do |id, service|      
        @worksheet = @workbook.create_worksheet :name => "Service | #{service.name.gsub(/\W/, '-')}"
        
        # create service header and set format
        @nextRow = 0
        setHeader(SpreadsheetConstants.SERVICE_HEADER)
          
        success = service.fetchComponents
        next unless success
        
        @nextRow += 1
        @isRestService = service.technology.include?("REST")
        writeToSpreadsheet(service)
      end
      
      # finalise
      @workbook.write(@file.path)
      @file.close
    
      return @file
    rescue Exception => ex
      log('e', ex)
      File.delete(@file.path) if @file
      return nil
    end # begin rescue
  end # self.generateSpreadsheet

private

  def self.writeToSpreadsheet(service)
    serviceType = "#{service.technology.upcase} Service"
    # write service row and format
    @worksheet[@nextRow, SpreadsheetConstants.column(:id)] = service.id
    @worksheet[@nextRow, SpreadsheetConstants.column(:type)] = serviceType
    @worksheet[@nextRow, SpreadsheetConstants.column(:name)] = service.name

    3.times { |x| @worksheet.row(@nextRow).set_format(x, @@formats[:service]) }
    @worksheet.row(@nextRow).height *= SpreadsheetConstants::HEIGHT_MULTIPLIER

    writeDescriptions(service.descriptions, @@formats[:service], serviceType)

    unless service.components.empty?
      # set header for top level components
      @nextRow += 3
      setHeader(SpreadsheetConstants.COMPONENT_HEADER)

      # iterate over top level components
      @nextRow += 1
      writeServiceComponents(service) 
    end
  end # self.writeToSpreadsheet
  
  def self.setHeader(header)
    @worksheet.row(@nextRow).concat(header)
    header.size.times { |cell|
      @worksheet.row(@nextRow).set_format(cell, @@formats[:header]) 
      @worksheet.column(cell).width = SpreadsheetConstants.widthFor(cell)
    }
    @worksheet.row(@nextRow).height *= SpreadsheetConstants::HEIGHT_MULTIPLIER
  end # self.setHeader

  def self.writeServiceComponents(service)
    service.components.each do |id, component|
      # write operation
      type = @isRestService ? "REST Endpoint" : "SOAP Operation"
      writeComponentRow(@@formats[:component], type, id, component.name, component.descriptions)
              
      # write inputs
      component.inputs.each do |id, input|
        writeComponentRow(@@formats[:input], Application.displayNameForResourceType(input.resourceType), id, input.name, input.descriptions)
      end # component.inputs.each
      
      # write outputs
      component.outputs.each do |id, output|
        writeComponentRow(@@formats[:output], Application.displayNameForResourceType(output.resourceType), id, output.name, output.descriptions)
      end # component.outputs.each
    end # service.components.each
  end # self.writeServiceComponents
  
  def self.writeComponentRow(format, displayName, id, name, descriptions)
    # write ID
    @worksheet[@nextRow, SpreadsheetConstants.column(:id)] = id
    @worksheet.row(@nextRow).set_format(0, @@formats[:gray])

    # write displayName and NAME
    @worksheet[@nextRow, SpreadsheetConstants.column(:type)] = displayName
    @worksheet[@nextRow, SpreadsheetConstants.column(:name)] = name
    
    writeDescriptions(descriptions, format, displayName)
    
    @nextRow += 1
  end # self.writeComponentRow

  def self.writeDescriptions(descriptions, format, displayName)
    if descriptions.empty?
      finalizeRowWithFormat(format, displayName)
    else
      descriptions.each do |desc|
        @worksheet[@nextRow, SpreadsheetConstants.column(:descriptions)] = desc
        finalizeRowWithFormat(format, displayName)
      end # descriptions.each
    end # if else descriptions.empty?
  end # self.writeDescriptions
  
  def self.finalizeRowWithFormat(format, displayName)
    @worksheet.row(@nextRow).set_format(SpreadsheetConstants.column(:type), format)
    @worksheet.row(@nextRow).set_format(SpreadsheetConstants.column(:name), format)    
    @worksheet.row(@nextRow).set_format(SpreadsheetConstants.column(:descriptions), @@formats[:notAllowed]) # field is grayed out
    
    case displayName.downcase
      when "soap operation"
        @worksheet.row(@nextRow).set_format(SpreadsheetConstants.column(:examples), @@formats[:notAllowed])
        @worksheet.row(@nextRow).set_format(SpreadsheetConstants.column(:dataFormats), @@formats[:notAllowed])      
      when "soap input", "soap output"
      when "rest endpoint", "rest method"
        @worksheet.row(@nextRow).set_format(SpreadsheetConstants.column(:dataFormats), @@formats[:notAllowed])      
      when "rest parameter"
        @worksheet.row(@nextRow).set_format(SpreadsheetConstants.column(:dataFormats), @@formats[:notAllowed])      
      when "rest representation"                
    end
    
    @worksheet.row(@nextRow).height *= SpreadsheetConstants::HEIGHT_MULTIPLIER
    
    @nextRow += 2
  end # self.finalizeRowWithFormat

end # module SpreadsheetGeneration
