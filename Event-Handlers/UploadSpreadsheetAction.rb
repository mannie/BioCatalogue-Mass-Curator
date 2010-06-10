#
#  UploadSpreadsheetAction.rb
#  BioCatalogue-Mass-Curator
#
#  Created by Mannie Tagarira on 20/05/2010.
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

class UploadSpreadsheetAction
  java_implements ActionListener

  @selectedFilePath = nil
  
  def initialize(container)
    super()
    @buttonContainer = container
        
    return self
  end # initialize

# --------------------
  
  def actionPerformed(event)
    if @buttonContainer.instance_of?(MainPanel)
      @buttonContainer.setVisible(false)
      
      # @@loginPanel ||= LoginPanel.new
      # @@loginPanel.setVisible(true)
      
      @@uploadPanel ||= UploadSpreadsheetPanel.new
      @@uploadPanel.setVisible(true)
      @buttonContainer.setVisible(false)

      MAIN_WINDOW.getContentPane.add(@@uploadPanel)
      MAIN_WINDOW.getContentPane.repaint
    
    elsif @buttonContainer.instance_of?(UploadSpreadsheetPanel)
      
      if event.getSource==@buttonContainer.selectSpreadsheetButton
        @@fileSelector ||= JFileChooser.new
        @@filter ||= FileNameExtensionFilter.new("Excel Spreadsheets", "xls")
        @@fileSelector.setAcceptAllFileFilterUsed(false)
        @@fileSelector.setFileFilter(@@filter)
    
        if @@fileSelector.showOpenDialog(MAIN_WINDOW) == 
            JFileChooser::APPROVE_OPTION
          @selectedFilePath = @@fileSelector.getSelectedFile.getAbsolutePath
          @buttonContainer.selectedSpreadsheetLabel.setText(@selectedFilePath)
          @buttonContainer.selectedSpreadsheetLabel.setEnabled(true)
          
          @buttonContainer.uploadSpreadsheetButton.setEnabled(true)
        end # if file selected
      elsif event.getSource==@buttonContainer.uploadSpreadsheetButton        
        return if @selectedFilePath.nil?
                
        Thread.new("Posting annotation data") {
          event.getSource.setEnabled(false)
          event.getSource.setText("Uploading...")
          event.getSource.setIcon(Resource.iconFor('busy'))
          
          jsonOutput = SpreadsheetParsing.generateJSONFromSpreadsheet(
              @selectedFilePath)
          
          if jsonOutput
            proceed = true
            
            if jsonOutput.empty?
              Notification.informationDialog(
                  "No new annotations could be found in the spreadsheet.\n" +
                  "Nothing has been sent to BioCatalogue.", 
                  "No New Annotations Found")
              proceed = false
            end
            
            if proceed
              user = @buttonContainer.usernameField.getText
              pass = @buttonContainer.passwordField.getText
              
              if Application.postAnnotationData(jsonOutput, user, pass)
                Notification.informationDialog(
                    "Your annotations have been successfully sent.", "Success")
              else
                Notification.errorDialog(
                    "An error occured while trying to send your annotations.")
              end
            end # if proceed
          else
            Notification.errorDialog(
                "An error occured while uploading your spreadsheet.")
          end # if jsonOutput 
          
          event.getSource.setIcon(Resource.iconFor('upload'))
          event.getSource.setText("Upload")
          event.getSource.setEnabled(true)
        } # Thread.new
      end # elsif event.getSource==@buttonContainer.uploadSpreadsheetButton

    end # elsif @buttonContainer.instance_of?(UploadSpreadsheetPanel)
  end # actionPerformed

end
