#
#  main.rb
#  BioCatalogue-Mass-Curator
#
#  Created by Mannie Tagarira on 19/05/2010.
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

require 'optparse'

CONFIG = { :doBenchmark => false, 
           :host => 'http://www.biocatalogue.org',
           :servicesPerPage => 10,
           :searchResultsPerPage => 10 }
    
ARGV.options do |opts|
  opts.on("-h", "--help", "Show this help message.") { puts opts; exit }
  
  opts.separator ""
  
  opts.on("--benchmark=boolean", "Run and display benchmark information.") { |a|
    CONFIG[:doBenchmark] = a=="true" 
  }
  
  opts.separator ""
  
  opts.on("--host=hostname", "Specify a BioCatalogue instance's hostname") { |a|
    CONFIG[:host] = a 
  }
  
  opts.separator ""

  opts.on("--services-per-page=X", 
          "The number of services to show per page while browsing.",
          "See also --search-results-per-page") { |a|
    CONFIG[:servicesPerPage] = a.to_i
  }
  
  opts.on("--search-results-per-page=X", 
          "The number of service to show per page in the search results.",
          "See also --services-per-page") { |a|
    CONFIG[:searchResultsPerPage] = a.to_i
  }
  
  opts.parse!
end

if CONFIG[:doBenchmark]

  require 'benchmark'
  
  Benchmark.bm do |b| 

    b.report("Cons") {
      require File.join(File.dirname(__FILE__), 'application_constants.rb')
    }
    
    b.report("Libr") {
      require File.join(File.dirname(__FILE__), 'application_requires.rb')
    }

    b.report("Clie") { 
      biocatalogueClient = BioCatalogueClient.new(CONFIG[:host]) 
    }
    
    b.report("Sele") { SELECTED_SERVICES_WINDOW = SelectedServicesWindow.new }

    b.report("Main") { MAIN_WINDOW = MainWindow.new }
    
    
  end
  
else # !CONFIG[:doBenchmark]
  
  require File.join(File.dirname(__FILE__), 'application_constants.rb')
  require File.join(File.dirname(__FILE__), 'application_requires.rb')

  biocatalogueClient = BioCatalogueClient.new(CONFIG[:host])
  SELECTED_SERVICES_WINDOW = SelectedServicesWindow.new
  MAIN_WINDOW = MainWindow.new
  
end
