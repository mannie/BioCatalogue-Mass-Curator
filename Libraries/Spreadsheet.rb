#
#  Spreadsheet.rb
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

module Application
  module Curation

    def self.generateSpreadsheet(services)
      # initialise
      Spreadsheet.client_encoding = 'UTF-8'
      formats = define_spreadsheet_formatting
             
      file_name = "test_spreadsheet.xls"
      reports_dir = "#{APP_ROOT}/tmp/"
            
      File.makedirs(reports_dir)
      file = File.new(File.join(reports_dir, file_name), "w+")
      workbook = Spreadsheet::Workbook.new(file.path)  
      
      worksheet = workbook.create_worksheet :name => "Annotate Services"
      
      # create header and set format
      next_row = 0
      worksheet.row(next_row).concat %w{ ID Categories Type Name Descriptions Tags Examples }  
      7.times { |x| worksheet.row(next_row).set_format(x, formats[:header]) }
=begin      
      raise if services.nil?
      
      # loop through services and write to workbook
      services.each do |service|
        next_row += 1
        next_row = write_to_spreadsheet(worksheet, next_row, formats, service)
      end          
=end      
      # finalise
      workbook.write(file.path)
      file.close
      
#      dl_path = file.path.gsub(APP_ROOT, '')
      return "<a href='#{dl_path}'>#{file_name}</a>"
    end
  
  private

    def self.define_spreadsheet_formatting
      size = 11
      patt = 1
      
      h = Spreadsheet::Format.new(:size => size + 1, :pattern_fg_color => :grey, :pattern => patt, :weight => :bold, :align => :center)
      s = Spreadsheet::Format.new(:size => size, :pattern_fg_color => :magenta, :pattern => patt, :weight => :bold)                                 
      op = Spreadsheet::Format.new(:size => size, :pattern_fg_color => :green, :pattern => patt)                                     
      i = Spreadsheet::Format.new(:size => size, :pattern_fg_color => :cyan, :pattern => patt)
      o = Spreadsheet::Format.new(:size => size, :pattern_fg_color => :brown, :pattern => patt)
      bs = Spreadsheet::Format.new(:pattern_fg_color => :black, :pattern => patt)
      
      return { :header => h, 
               :service => s, 
               :operation => op, 
               :input => i, 
               :output => o,
               :black_seperator => bs }        
    end
    
    def self.write_to_spreadsheet(worksheet, next_row, formats, service)
      is_rest = service.latest_version.service_versionified_type=="RestService" 
      
      # write service row and format
      worksheet[next_row, 0] = service.id
      worksheet[next_row, 2] = (is_rest ? "REST Service" : "SOAP Service")
      worksheet[next_row, 3] = service.name                 
      7.times { |x| worksheet.row(next_row).set_format(x, formats[:service]) }
      
      # iterate over operations/endpoints
      next_row += 1 
      service = service.latest_version.service_versionified
      if is_rest
        next_row = write_rest_components(worksheet, next_row, formats, service)
      else
        next_row = write_soap_components(worksheet, next_row, formats, service)
      end
      
      next_row += 1
      return next_row
    end
    
    def self.write_rest_components(worksheet, next_row, formats, service)
      service.rest_resources.sort.each do |res|
        res.rest_methods.sort.each do |meth|
          # write endpoint
          next_row = write_component_row(worksheet, next_row, formats[:operation], "REST Endpoint", meth.display_name)
                    
          # write parameters
          meth.request_parameters.each do |param|
            next_row = write_component_row(worksheet, next_row, formats[:input], "REST Parameter", param.name)
          end # meth.request_parameters.each
        end # rest_methods.sort.each
      end # service.rest_resources.sort.each
      
      return next_row
    end
    
    def self.write_soap_components(worksheet, next_row, formats, service)
      service.soap_operations.each do |op|
        # write operation   
        next_row = write_component_row(worksheet, next_row, formats[:operation], "SOAP Operation", op.name)
                
        # write inputs
        op.soap_inputs.each do |input|
          next_row = write_component_row(worksheet, next_row, formats[:input], "SOAP Input", input.name)
        end # meth.request_parameters.each
        
        # write outputs
        op.soap_outputs.each do |output|
          next_row = write_component_row(worksheet, next_row, formats[:output], "SOAP Output", output.name)
        end # meth.request_parameters.each
      end # service.soap_operations.each
      
      return next_row
    end
    
    def self.write_component_row(worksheet, next_row, format, type, name)
      worksheet[next_row, 2] = type
      worksheet[next_row, 3] = name
      5.times { |x| worksheet.row(next_row).set_format(x + 2, format) }
      next_row += 1
      return next_row
    end
  
  end
end
