#
#  SearchResultsWindow.rb
#  BioCatalogue-Mass-Curator
#
#  Created by Mannie Tagarira on 07/06/2010.
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

class SearchResultsWindow < JFrame
  
  @@lastSearchResultsWindow = nil
  
  def initialize(query)
    super("Search results for: " + query)
    
    @query = query
    
    initUI
    
    @@lastSearchResultsWindow.dispose if @@lastSearchResultsWindow
    @@lastSearchResultsWindow = self

    return self
  end # initialize
  
private

  def initUI
    self.getContentPane.add(searchResultsPanel)
    
    self.setMinimumSize(Dimension.new(300, 100))
    self.pack
    
    self.setDefaultCloseOperation(JFrame::DISPOSE_ON_CLOSE)

    Component.centerToParent(self, MAIN_WINDOW)
    self.setVisible(true)
  end # initUI

  def searchResultsPanel
    panel = JPanel.new
    panel.setLayout(GridBagLayout.new)
    
    c = GridBagConstraints.new
    c.anchor = GridBagConstraints::NORTHWEST
    c.fill = GridBagConstraints::HORIZONTAL
    c.insets = Insets.new(1, 2, 1, 2)
    c.weightx = 2
    c.gridy = 0

    begin
      xmlDocument = XMLUtil.getXMLDocumentFromURI(
          BioCatalogueClient.searchEndpoint(
              @query, 'xml', CONFIG['application']['search-results-per-page']))
    rescue Exception => ex
      log('e', ex)
    end
    
    @localServiceCache = []
    @localListingCache = []
    
    xmlDocument.root.each { |node|
      case node.name
        when 'results'
          if XMLUtil.getServiceListingsFromNode(
              node, @localServiceCache, @localListingCache)
            @localListingCache.each { |listing|
              panel.add(listing, c)
              c.gridy += 1
            }
          end
      end # case
    } # xmlDocument.root.each
    
    return (@localServiceCache.empty? ? 
        JLabel.new("No services matched '#{@query}'", SwingConstants::CENTER) : 
        JScrollPane.new(panel))
  end # searchResultsPanel
  
end # SearchResultsWindow
