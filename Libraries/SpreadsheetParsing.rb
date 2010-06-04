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
   along with this program.  If not, see http://www.gnu.org/licenses/gpl.html.
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
          log('w', nil, "Check that the service components have changed")
          @header.size.times do |cell|
            case @header[cell]
              when "ID"
                id = row[cell]
              when "Type": 
                resource = Utilities::Application.resourceNameFor(row[cell])
                link = Utilities::Application.weblinkWithIDForResource(id, 
                    resource)
                entry.merge!('resource' => link.to_s)
              when "Description"
                annotations.merge!('description' => row[cell]) if row[cell]
              when "Tags"
                annotations.merge!('tag' => row[cell].split(',')) if row[cell]
              when "Examples"
                annotations.merge!('example_data' => row[cell].split(',')) if 
                    row[cell]
            end # case property
          end # @header.each
          
          # consolidate the entry
          entry.merge!('annotations' => annotations)
          bulk_annotations << entry
          
        end # if else row == first        
      end # each row in the workboow
      
      content = {'bulk_annotations' => bulk_annotations}
      return content.to_json

    rescue Exception => ex
      log('e', ex)
      return nil
    end # begin rescue
  end # self.generateJSONFromSpreadsheet
  
end # module SpreadsheetParsing
