#
#  ServiceSelectPanel.rb
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

class ServiceSelectPanel < JPanel
  
  attr_reader :localServiceCache, :localListingCache, :mainPanel
  attr_reader :previousPageButton, :nextPageButton
    
  def initialize(pageNumber)
    super()

    @page = pageNumber.to_i
    initUI

    Component.browsingStatusPanel.pageCount = @lastPage
    
    return self
  end # initialize
  
private
  
  def initUI
    self.setLayout(BorderLayout.new)  
    
    self.add(Component.searchPanel, BorderLayout::NORTH)
    self.add(@mainPanel ||= mainScrollPane)
    self.add(Component.browsingStatusPanel, BorderLayout::SOUTH)
        
    # button to previous page
    @previousPageButton = JButton.new(Resource.iconFor('back-arrow'))
    @previousPageButton.addActionListener(LoadServicesAction.new(self, @page-1))
    @previousPageButton.setEnabled(false) if @page==1
    self.add(@previousPageButton, BorderLayout::WEST)
    
    # button to next page
    @nextPageButton = JButton.new(Resource.iconFor('forward-arrow'))
    @nextPageButton.addActionListener(LoadServicesAction.new(self, @page+1))
    @nextPageButton.setEnabled(false) if @page==@lastPage
    self.add(@nextPageButton, BorderLayout::EAST)
  end # initUI
  
private
  
  def mainScrollPane
    panel = JPanel.new
    panel.setLayout(GridBagLayout.new)
    
    c = GridBagConstraints.new
    c.anchor = GridBagConstraints::NORTHWEST
    c.fill = GridBagConstraints::HORIZONTAL
    c.insets = Insets.new(5, 5, 5, 5)
    c.weightx = 2
    c.gridy = 0

    begin
      uri = BioCatalogueClient.servicesEndpoint('json', CONFIG['application']['services-per-page'], @page)
      document = JSONUtil.getDocumentFromURI(uri)
      raise "Could not load services." if document.nil? || document['services'].nil?
    rescue Exception => ex
      log('f', ex)
      java.lang.System::exit(0)
    end
    
    @localServiceCache = []
    @localListingCache = []
    
    @lastPage = document['services']['pages']
    
    if JSONUtil.getServiceListingsFromNode(document['services']['results'], @localServiceCache, @localListingCache)
      @localListingCache.each { |listing|
        panel.add(listing, c)
        c.gridy += 1
      }
    end
        
    return JScrollPane.new(panel)
  end # mainScrollPane
  
end # ServiceSelectPanel

