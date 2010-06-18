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

  def self.generateJSONFromSpreadsheet(filePath)
    begin
      raise "Invalid file path" if filePath.nil? || filePath.empty?
      
      Spreadsheet.client_encoding = 'UTF-8'
      @workbook = Spreadsheet.open(filePath)
      
      # init work vars
      bulkAnnotations = []      
      
      @workbook.worksheets.each do |worksheet| # iterate each worksheet
        worksheet.each do |row| # iterate each row of the worksheet
          if row==worksheet.first
            @header = row.to_a
            raise "Incompatible spreadsheet format" unless @header==SpreadsheetConstants.HEADER
          else # all other rows
            # set up temp storage vars
            entry = {}
            annotations = {}
            
            description, tags, examples = nil, nil, nil
            
            # fill in vars with the spreadsheet values
            @header.size.times do |cell|
              case cell
                when SpreadsheetConstants.column(:id)
                  @id = row[cell] if row[cell]
                when SpreadsheetConstants.column(:type)
                  unless @id
                    @resource, @service, @component = nil, nil. nil
                    break
                  end
                  
                  @resource = Application.resourceNameFor(row[cell]) if
                      row[cell]

                  if @resource=='soap_services'
                    uri = Application.weblinkWithIDForResource(@id)
                    @service = Application.serviceWithURI(uri.to_s)
                    @service.fetchComponents

                    entry.merge!('resource' => @service.variantURI.to_s)
                  else
                    @component = @service.components[@id] if @resource==
                        'soap_operations'

                    uri = Application.weblinkWithIDForResource(@id, @resource)
                    
                    entry.merge!('resource' => uri.to_s)
                  end # if else resource=='soap_services'
                when SpreadsheetConstants.column(:newDescriptions)
                  break unless @id
                  
                  originals = case @resource
                                when 'soap_services'
                                  @service.descriptions
                                when 'soap_operations'
                                  @component.descriptions
                                when 'soap_inputs'
                                  @component.inputs[@id].descriptions
                                when 'soap_outputs'
                                  @component.outputs[@id].descriptions
                              end # case resource
                  
                  isNew = row[cell] && !originals.include?(row[cell])
                  annotations.merge!('description' => row[cell]) if isNew
                when SpreadsheetConstants.column(:tags)
                  break unless @id
                  
                  annotations.merge!('tag' => row[cell].to_s.split(',')) if 
                      row[cell]
                when SpreadsheetConstants.column(:examples)
                  break unless @id
                  
                  allow = row[cell] && !@resource=~/(service|operation)/i
                  annotations.merge!(
                      'example_data' => row[cell].to_s.split(',')) if allow
              end # case property
            end # @header.each
            
            # consolidate the entry
            unless annotations.empty?
              entry.merge!('annotations' => annotations)
              bulkAnnotations << entry
            end
            
          end # if else row == first        
        end # worksheet.each
      end # workbook.worksheets.each
      
      content = {'bulk_annotations' => bulkAnnotations}
      return (bulkAnnotations.empty? ? '' : content.to_json)

    rescue Exception => ex
      log('e', ex)
      return nil
    end # begin rescue
  end # self.generateJSONFromSpreadsheet
  
end # module SpreadsheetParsing
