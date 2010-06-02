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
      
      Thread.new("Generating spreadsheet") { |t|
        event.getSource.setEnabled(false)
        originalButtonCaption = event.getSource.getText
        event.getSource.setText("Exporting...")
        
        file = Curation.generateSpreadsheet(BioCatalogueClient.selectedServices,
            dir.path)

        if file
          JOptionPane.showMessageDialog(MAIN_WINDOW,
              "The selected services have been successfully exported to:\n" + 
              file.path,"Export Complete", JOptionPane::INFORMATION_MESSAGE)
        else
          JOptionPane.showMessageDialog(MAIN_WINDOW, "Error", 
              "An error occured while trying to export the selected services.",
              JOptionPane::ERROR_MESSAGE)
        end
        
        event.getSource.setEnabled(true)
        event.getSource.setText(originalButtonCaption)
      }
      
    end # if    
  
    LoadServicesAction.setBusyExporting(false)    
  end # actionPerformed
  
end
