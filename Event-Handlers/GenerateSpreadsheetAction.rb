#
#  GenerateSpreadsheetAction.rb
#  BioCatalogue-Mass-Curator
#
#  Created by Mannie Tagarira on 21/05/2010.
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

class GenerateSpreadsheetAction

  def initialize(container)
    super()
    @buttonContainer = container
    return self
  end # initialize

  def actionPerformed(event)
    @@fileSelector ||= JFileChooser.new
    @@fileSelector.setFileSelectionMode(JFileChooser::DIRECTORIES_ONLY)

    LoadServicesAction.setBusyExporting(true)

    if @@fileSelector.showOpenDialog(MAIN_WINDOW) == 
        JFileChooser::APPROVE_OPTION
      dir = @@fileSelector.getSelectedFile()
      return if dir.nil? || !dir.isDirectory
      
      file = Curation.generateSpreadsheet(
          BioCatalogueClient.selectedServices, dir.path)
      
      LOG.warn "TODO: popup for confirmation"
    end # if    
  
    LoadServicesAction.setBusyExporting(false)    
  end # actionPerformed
  
end
