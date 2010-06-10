#
#  LoadServicesAction.rb
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

class LoadServicesAction
  java_implements ActionListener

  @@resultsPanelForPage = {}
  @@serviceSelectPanel = nil
  
  def initialize(container, pageNumber)
    super()
    @buttonContainer = container
    @pageNumber = pageNumber
    return self
  end # initialize

  def setLoadPageNumber(page)
    @pageNumber = page
  end # setLoadPageNumber

# --------------------
  
  def self.currentPage
    @@currentPage
  end # self.currentPage
  
  def self.setServicesPanelVisible(visible)
    @@serviceSelectPanel.setVisible(visible) if @@serviceSelectPanel
  end # self.setServicesPanelVisible

   
  def self.setBusyExporting(exporting)
    Component.searchPanel.setVisible(!exporting)
    Component.browsingStatusPanel.setVisible(!exporting)
    @@serviceSelectPanel.previousPageButton.setVisible(!exporting)
    @@serviceSelectPanel.nextPageButton.setVisible(!exporting)
    @@serviceSelectPanel.mainPanel.setVisible(!exporting)
    
    Component.flash(@@serviceSelectPanel)
  end # self.setBusyExporting
  
# --------------------
  
  def actionPerformed(event)    
    # set page number to be used by the GoBackAction
    @@currentPage = @pageNumber
        
    # load new service select panel
    if (panel = @@resultsPanelForPage[@pageNumber])
      @@serviceSelectPanel = panel
            
      panel.add(Component.searchPanel, BorderLayout::NORTH)
      panel.add(Component.browsingStatusPanel, BorderLayout::SOUTH)
      
      Cache.syncWithCollection(panel.localServiceCache)
      Cache.updateServiceListings(panel.localListingCache)
    else
      @@serviceSelectPanel = ServiceSelectPanel.new(@pageNumber)
      @@resultsPanelForPage.merge!(@pageNumber => @@serviceSelectPanel)
    end
    
    # update status.actions panel
    Component.browsingStatusPanel.currentPage = @pageNumber
    Component.browsingStatusPanel.exportButton.setEnabled(
        !Cache.selectedServices.empty?) unless
        GenerateSpreadsheetAction.isBusyExporting
    Component.browsingStatusPanel.refresh
    
    # update full view to show new services
    @buttonContainer.setVisible(false)
    @@serviceSelectPanel.setVisible(true)
    
    MAIN_WINDOW.getContentPane.add(@@serviceSelectPanel)
    MAIN_WINDOW.getContentPane.repaint
  end # actionPerformed

end
