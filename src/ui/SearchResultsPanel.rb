#
#  SearchResultsPanel.rb
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

class SearchResultsPanel < JPanel

  attr_reader :localServiceCache, :localListingCache, :mainPanel
  attr_reader :previousPageButton, :nextPageButton
  attr_reader :query
  
  @@lastPageStatusLabelUsed = nil
  @@lastPage = nil
  
  def initialize(query, pageNumber)
    super()

    @query, @page = query, pageNumber.to_i
    
    initUI

    return self
  end # initialize
  
private
  
  def initUI
    self.setLayout(BorderLayout.new)  

    self.add(@mainPanel ||= mainScrollPane)
    
    # current page label
    self.remove(@@lastPageStatusLabelUsed) if @@lastPageStatusLabelUsed
    @@lastPageStatusLabelUsed = JLabel.new(
        "Page #{@page} of #{@@lastPage}", SwingConstants::CENTER)
    self.add(@@lastPageStatusLabelUsed, BorderLayout::SOUTH)
        
    # button to previous page
    @previousPageButton = JButton.new(Resource.iconFor('back-arrow'))
    @previousPageButton.addActionListener(
        LoadSearchPageAction.new(self, @page-1))
    @previousPageButton.setEnabled(false) if @page==1
    self.add(@previousPageButton, BorderLayout::WEST)
    
    # button to next page
    @nextPageButton = JButton.new(Resource.iconFor('forward-arrow'))
    @nextPageButton.addActionListener(LoadSearchPageAction.new(self, @page+1))
    @nextPageButton.setEnabled(false) if @page==@@lastPage
    self.add(@nextPageButton, BorderLayout::EAST)
  end # initUI
  
private
  
  def mainScrollPane
    panel = JPanel.new
    panel.setLayout(GridBagLayout.new)
    
    c = GridBagConstraints.new
    c.anchor = GridBagConstraints::NORTHWEST
    c.fill = GridBagConstraints::HORIZONTAL
    c.insets = Insets.new(1, 2, 1, 2)
    c.weightx = 2
    c.gridy = 0

    begin
      xmlDocument = XMLUtils.getXMLDocumentFromURI(
          BioCatalogueClient.searchEndpoint(@query, 'xml', 
              CONFIG['application']['search-results-per-page'], @page))
    rescue Exception => ex
      log('e', ex)
    end

    @localServiceCache = []
    @localListingCache = []
    
    xmlDocument.root.each { |node|
      case node.name
        when 'results'
          if XMLUtils.getServiceListingsFromNode(
              node, @localServiceCache, @localListingCache)
            @localListingCache.each { |listing|
              panel.add(listing, c)
              c.gridy += 1
            }
          end
        when 'statistics'
          break if @@lastPage
          
          statsNodes = XMLUtils.getValidChildren(node)
          statsNodes.each { |node|
            case node.name
              when 'pages'
                @@lastPage = node.content.to_i
            end # case
          }
      end # case
    } # xmlDocument.root.each
        
    return (@localServiceCache.empty? ? 
        JLabel.new("No services matched query\n'#{@query}'", 
            SwingConstants::CENTER) : 
        JScrollPane.new(panel))
  end # mainScrollPane

end # SearchResultsPanel