#
#  SearchAction.rb
#  BioCatalogue-Mass-Curator
#
#  Created by Mannie Tagarira on 15/06/2010.
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

class SearchAction
  java_implements ActionListener

  @@resultsPanelForPage = {}
  @@searchResultsPanel = nil

  @@searchResultsWindow = nil
  
  @@query = ''
  
  def initialize(container, pageNumber)
    super()
    @buttonContainer = container
    @pageNumber = pageNumber
        
    return self
  end # initialize

# --------------------
  
  def actionPerformed(event)
    if @buttonContainer.class==SearchPanel
      @@resultsPanelForPage = {}
      @@searchResultsPanel = nil
      @@query = @buttonContainer.query
      
      @@searchResultsWindow.dispose if @@searchResultsWindow
      @@searchResultsWindow = SearchResultsWindow.new(@@query)
      @@positionSet = false
    end
    
    Thread.new("Loading search: #{@@query} results page ##{@pageNumber}") {
      # disable browsing buttons
      if @buttonContainer.class==SearchPanel
        event.getSource.setText("Searching...")
        event.getSource.setEnabled(false)
      else
        previousPageEnabled = @buttonContainer.previousPageButton.isEnabled
        nextPageEnabled = @buttonContainer.nextPageButton.isEnabled
        searchEnabled = Component.searchButton.isEnabled
        
        @buttonContainer.previousPageButton.setEnabled(false)
        @buttonContainer.nextPageButton.setEnabled(false)
      end
      
      Component.searchField.setEnabled(false)
      Component.searchButton.setEnabled(false)

      # update source icon
      originalIcon = event.getSource.getIcon
      event.getSource.setIcon(Resource.iconFor('busy'))

      # load new search results panel
      if (panel = @@resultsPanelForPage[@pageNumber])
        @@searchResultsPanel = panel

        Cache.syncWithCollection(panel.localServiceCache)
        Cache.updateServiceListings(panel.localListingCache)
      else
        @@searchResultsPanel = SearchResultsPanel.new(@@query, @pageNumber)
        @@resultsPanelForPage.merge!(@pageNumber => @@searchResultsPanel)
      end
      
      # update full view to show search results
      @buttonContainer.setVisible(false) if @buttonContainer.class!=SearchPanel
      @@searchResultsPanel.setVisible(true)
      
      @@searchResultsWindow.getContentPane.add(@@searchResultsPanel)
      @@searchResultsWindow.getContentPane.repaint
      @@searchResultsWindow.pack
      
      unless @@positionSet
        Component.centerToParent(@@searchResultsWindow, MAIN_WINDOW)
        @@positionSet = true
      end
      
      @@searchResultsWindow.setVisible(true)

      # update source icon
      event.getSource.setIcon(originalIcon)
      
      # re-enable browsing buttons 
      Component.searchButton.setEnabled(searchEnabled)
      Component.searchField.setEnabled(true)

      if @buttonContainer.class==SearchPanel
        event.getSource.setText("Search") 
        event.getSource.setEnabled(true)
      else
        @buttonContainer.nextPageButton.setEnabled(nextPageEnabled)
        @buttonContainer.previousPageButton.setEnabled(previousPageEnabled)
      end
    }
  end # actionPerformed

end # SearchAction
