#
#  SpreadsheetParsing.rb
#  BioCatalogue-Mass-Curator
#
#  Created by Mannie Tagarira on 03/06/2010.
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

module SpreadsheetParsing
  
  @@successfullyParsedServices = []

  def self.performAfterPostActions
    Thread.new("Force refreshing services from spreadsheet...") {
      @@successfullyParsedServices.each { |x| x.fetchComponents(true) }
    }
  end
  
  def self.generateJSONFromSpreadsheet(filePath)
    @@successfullyParsedServices = []

    begin
      raise "Invalid file path" if filePath.nil? || filePath.empty?
      
      # init work vars
      @bulkAnnotations = []      

      @workbook = HSSFWorkbook.new(FileInputStream.new(filePath))

      @workbook.getNumberOfSheets.times do |sheet_index|        
        begin          
          next if @workbook.getSheetName(sheet_index).strip.downcase=="help"
          
          parseWorksheet(@workbook.getSheetAt(sheet_index))
          # @@successfullyParsedServices << @service
        rescue Exception => ex
          log('e', ex)
          next
        end # begin rescue

      end # @workbook.getNumberOfSheets
      
      content = {'bulk_annotations' => @bulkAnnotations}
      return (@bulkAnnotations.empty? ? '' : content.to_json)
    rescue Exception => ex
      log('e', ex)
      return nil
    end # begin rescue
  end # self.generateJSONFromSpreadsheet
  
private

  def self.addServiceAnnotation(value, type)
    return false unless @id && @resource
    return false unless @resource.include?("service")
    
    if type=='cost' || type=='usage_condition' || type=='contact'
      @deploymentAnnotations.merge!(type => value) if value
    else
      @annotations.merge!(type => value) if value
    end
    
    return true
  end # self.addServiceAnnotation
  
  def self.setHeaderFromRow(row)
    cells = []
    
    row.each { |c| 
      cells << c.getStringCellValue if c.getCellType==HSSFCell::CELL_TYPE_STRING 
    }
    
    if cells==SpreadsheetConstants.SERVICE_HEADER || cells==SpreadsheetConstants.COMPONENT_HEADER
      @header = cells
      return true
    else
      return false
    end
  end # self.setHeaderFromRow
  
  def self.parseWorksheet(worksheet)
    worksheet.each do |row|
      next if setHeaderFromRow(row)
      
      # set up temp storage vars
      entry = {}
      @annotations = {}
      @deploymentAnnotations = {}
      
      row.each do |cell|
        case cell.getColumnIndex
          when SpreadsheetConstants.column(:id) # ID
            @id = cell.getNumericCellValue.to_i
          # --------------------
          when SpreadsheetConstants.column(:type) # Type
            unless @id
              @resource, @service, @component = nil, nil. nil
              break
            end

            @resource = Application.resourceTypeFor(cell.getStringCellValue)
            if @resource==Application.resourceTypeFor('soap service')
              uri = Application.weblinkWithIDForResource(@id)
              @service = Application.serviceWithURI(uri.to_s)
              @service.fetchComponents

              entry.merge!('resource' => @service.variantURI.to_s)
            else
              @component = @service.components[@id] if @resource=='soap_operations'

              uri = Application.weblinkWithIDForResource(@id, @resource)
              
              entry.merge!('resource' => uri.to_s)
            end # if else resource=='soap_services'
          # --------------------
          when SpreadsheetConstants.column(:newDescriptions) # Descriptions
            break unless @id && @resource

            originals = case @resource
                          when Application.resourceTypeFor('soap service')
                            @service.descriptions
                          when Application.resourceTypeFor('soap operation')
                            @component.descriptions
                          when Application.resourceTypeFor('soap input')
                            @component.inputs[@id].descriptions if @component.inputs[@id]
                          when Application.resourceTypeFor('soap output')
                            @component.outputs[@id].descriptions if @component.outputs[@id]
                        end # case resource
            
            isNew = originals && !cell.getStringCellValue.empty? && !originals.include?(cell.getStringCellValue)
            @annotations.merge!('description' => cell.getStringCellValue) if isNew
          # --------------------
          when SpreadsheetConstants.column(:tags) # Tags
            break unless @id && @resource
            
            tags = cell.getStringCellValue.split(',')
            @annotations.merge!('tag' => tags) unless tags.empty?
          # --------------------
          when SpreadsheetConstants.column(:examples) # Examples + DocumentationURL
            break unless @id && @resource
            
            if @resource.include?("service")
              break unless addServiceAnnotation(cell.getStringCellValue, 'documentation_url')
            elsif !@resource.include?("operation")
              @annotations.merge!('example_data' => cell.getStringCellValue)
            end
          # --------------------
          when SpreadsheetConstants.column(:licenses) # Licenses + Data Formats
            break unless @id && @resource

            if @resource.include?("service")
              break unless addServiceAnnotation(cell.getStringCellValue, 'license')
            elsif !@resource.include?("operation")
              @annotations.merge!('format' => cell.getStringCellValue)
            end
          # --------------------
          when SpreadsheetConstants.column(:contactInfo) # Contact Info
            break unless addServiceAnnotation(cell.getStringCellValue, 'contact')
          # --------------------
          when SpreadsheetConstants.column(:cost) # Cost
            break unless addServiceAnnotation(cell.getStringCellValue, 'cost')
          # --------------------
          when SpreadsheetConstants.column(:publications) # Publications
            break unless addServiceAnnotation(cell.getStringCellValue, 'publication')
          # --------------------
          when SpreadsheetConstants.column(:citations) # Citations
            break unless addServiceAnnotation(cell.getStringCellValue, 'citation')
          # --------------------
          when SpreadsheetConstants.column(:usageConditions) # Usage Conditions
            break unless addServiceAnnotation(cell.getStringCellValue, 'usage_condition')
          # --------------------
          when SpreadsheetConstants.column(:categories) # Categories
            if false # TODO: enable after API changes are made
              category = cell.getStringCellValue.chomp.strip.squeeze(" ")
              categoryID = SpreadsheetConstants.categoryID(category)

              break unless addServiceAnnotation(categoryID, 'category')
            end
        end # case cell.getColumnIndex
      end # row.each
      
      # consolidate the entry
      unless @annotations.empty?
        entry.merge!('annotations' => @annotations)
        @bulkAnnotations << entry
      end
      
      unless @deploymentAnnotations.empty?
        entry = { 'resource' => @service.deploymentURI.to_s,
                  'annotations' => @deploymentAnnotations }
        @bulkAnnotations << entry
      end
    end # worksheet.each
  end # self.parseWorksheet
  
end # module SpreadsheetParsing
