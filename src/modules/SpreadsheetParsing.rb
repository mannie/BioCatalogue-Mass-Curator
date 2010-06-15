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

      bulk_annotations = []
      
      # iterate each row of the worksheet
      @workbook.worksheets[0].each do |row|
        if row == @workbook.worksheets[0].first
          @header = row.to_a
        else # all other rows
          # set up temp storage vats
          entry = {}
          annotations = {}
          
          id, resource, name = nil, nil, nil
          description, tags, examples = nil, nil, nil
          
          # fill in vars with the spreadsheet values
          @header.size.times do |cell|
            case @header[cell]
              when "ID"
                break unless row[cell]
                id = row[cell]
              when "Type"
                resource = Application.resourceNameFor(row[cell])

                if resource=='soap_services'
                  uri = Application.weblinkWithIDForResource(id)
                  @service = Application.serviceWithURI(uri.to_s)
                  @service.fetchComponents

                  entry.merge!('resource' => @service.variantURI.to_s)
                else
                  @component = @service.components[id] if resource==
                      'soap_operations'

                  uri = Application.weblinkWithIDForResource(id, resource)
                  
                  entry.merge!('resource' => uri.to_s)
                end # if else resource=='soap_services'
              when "Description"
                break unless row[cell]
                
                originalDescrip = case resource
                                    when 'soap_services'
                                      @service.description
                                    when 'soap_operations'
                                      @component.description
                                    when 'soap_inputs'
                                      @component.inputs[id].description
                                    when 'soap_outputs'
                                      @component.outputs[id].description
                                  end # case resource
                
                altered = originalDescrip.chomp.strip != row[cell].chomp.strip
                annotations.merge!('description' => row[cell]) if altered
              when "Tags"
                annotations.merge!('tag' => row[cell].split(',')) if row[cell]
              when "Examples"
                annotations.merge!('example_data' => row[cell].split(',')) if 
                    row[cell]
            end # case property
          end # @header.each
          
          # consolidate the entry
          unless annotations.empty?
            entry.merge!('annotations' => annotations)
            bulk_annotations << entry
          end
          
        end # if else row == first        
      end # each row in the workboow
      
      content = {'bulk_annotations' => bulk_annotations}
      return (bulk_annotations.empty? ? '' : content.to_json)

    rescue Exception => ex
      log('e', ex)
      return nil
    end # begin rescue
  end # self.generateJSONFromSpreadsheet
  
end # module SpreadsheetParsing
