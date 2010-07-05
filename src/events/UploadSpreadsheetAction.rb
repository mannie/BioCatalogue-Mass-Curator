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
   along with this program.  If not, see http://www.gnu.org/licenses/gpl.html
=end

# This makes the calls to the modules that do the actual uploading.  This works
# as a UI updater.

# ========================================

class UploadSpreadsheetAction
  java_implements ActionListener

  @@selectedFilePath = nil
  @@uploadPanel = nil
  
  # ACCEPTS: the container of the button
  # RETURNS: self
  def initialize(container)
    super()
    @buttonContainer = container
        
    return self
  end # initialize

  # ACCEPTS: a boolean
  def self.setUploadPanelVisible(visible)
    @@uploadPanel.setVisible(visible) if @@uploadPanel
  end # self.setUploadPanelVisible
  
# --------------------
  
  def actionPerformed(event)
    if @buttonContainer.instance_of?(MainPanel) # show the UploadSpreadsheetPanel
      @buttonContainer.setVisible(false)
            
      @@uploadPanel ||= UploadSpreadsheetPanel.new
      @@uploadPanel.setVisible(true)
      @buttonContainer.setVisible(false)

      MAIN_WINDOW.getContentPane.add(@@uploadPanel)
      MAIN_WINDOW.getContentPane.repaint
    
    elsif @buttonContainer.instance_of?(UploadSpreadsheetPanel)
      
      if event.getSource==@buttonContainer.selectSpreadsheetButton
        # open the file select dialog
        @@fileSelector ||= JFileChooser.new
        @@filter ||= FileNameExtensionFilter.new("Excel Spreadsheets", "xls")
        @@fileSelector.setAcceptAllFileFilterUsed(false)
        @@fileSelector.setFileFilter(@@filter)
    
        if @@fileSelector.showOpenDialog(MAIN_WINDOW) == 
            JFileChooser::APPROVE_OPTION
          @@selectedFilePath = @@fileSelector.getSelectedFile.getAbsolutePath
          @buttonContainer.selectedSpreadsheetLabel.setText(@@selectedFilePath)
          @buttonContainer.selectedSpreadsheetLabel.setEnabled(true)
        
          user = @buttonContainer.usernameField.getText.strip
          pass = @buttonContainer.passwordField.getText.strip

          @buttonContainer.uploadSpreadsheetButton.setEnabled(true) if 
              !user.empty? && !pass.empty?
        end # if file selected
      elsif event.getSource==@buttonContainer.uploadSpreadsheetButton
        # upload the annotations
        return if @@selectedFilePath.nil?
        
        Thread.new("Posting annotation data") {
          # disable user interaction
          @buttonContainer.selectSpreadsheetButton.setEnabled(false)
          @buttonContainer.usernameField.setEnabled(false)
          @buttonContainer.passwordField.setEnabled(false)
          
          event.getSource.setEnabled(false)
          event.getSource.setText("Uploading...")
          event.getSource.setIcon(Resource.iconFor('busy'))
          
          jsonOutput = SpreadsheetParsing.generateJSONFromSpreadsheet(
              @@selectedFilePath)
          
          if jsonOutput # some annotation were returned
            proceed = true
            
            if jsonOutput.empty?
              Notification.informationDialog(
                  "No new annotations could be found in the spreadsheet.\n" +
                  "Nothing has been sent to BioCatalogue.", 
                  "No New Annotations Found")
              SpreadsheetParsing.performAfterPostActions

              proceed = false
            end
            
            user = @buttonContainer.usernameField.getText.strip
            pass = @buttonContainer.passwordField.getText.strip
            
            Application.postAnnotationData(jsonOutput, user, pass) if proceed &&
                !user.empty? && !pass.empty?
          else # failed to extract annotations
            Notification.errorDialog(
                "An error occured while uploading your spreadsheet.")
          end # if jsonOutput 
          
          # re-enable user interaction
          event.getSource.setIcon(Resource.iconFor('upload'))
          event.getSource.setText("Upload")
          event.getSource.setEnabled(true)
          
          @buttonContainer.passwordField.setEnabled(true)
          @buttonContainer.usernameField.setEnabled(true)
          @buttonContainer.selectSpreadsheetButton.setEnabled(true)
        } # Thread.new
      end # elsif event.getSource==@buttonContainer.uploadSpreadsheetButton

    end # elsif @buttonContainer.instance_of?(UploadSpreadsheetPanel)
  end # actionPerformed

end
