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
   along with this program.  If not, see http://www.gnu.org/licenses/gpl.html.
=end

class ServiceSelectPanel < JPanel
  
  attr_reader :localServiceCache
  
  SERVICES_PER_PAGE = 5
  
  def initialize(pageNumber)
    super()

    @page = pageNumber.to_i
    initUI
    MainWindow.ACTIONS_PANEL.pageCount = @lastPage

    return self
  end # initialize
  
private
  
  def initUI
    self.setLayout(BorderLayout.new)  
    
    self.add(MainWindow.SEARCH_PANEL, BorderLayout::NORTH)
    self.add(mainPanel)
    self.add(MainWindow.ACTIONS_PANEL, BorderLayout::SOUTH)
        
    # button to previous page
#    previousPageButton = BasicArrowButton.new(SwingConstants::WEST)
    previousPageButton = JButton.new("<<")
    previousPageButton.addActionListener(LoadServicesAction.new(self, @page-1))
    previousPageButton.setEnabled(false) if @page==1
    self.add(previousPageButton, BorderLayout::WEST)
    
    # button to next page
#    nextPageButton = BasicArrowButton.new(SwingConstants::EAST)
    nextPageButton = JButton.new(">>")
    nextPageButton.addActionListener(LoadServicesAction.new(self, @page+1))
    nextPageButton.setEnabled(false) if @page==@lastPage
    self.add(nextPageButton, BorderLayout::EAST)
  end # initUI
  
private
  
  def mainPanel
    panel = JPanel.new
    panel.setLayout(GridBagLayout.new)
    
    c = GridBagConstraints.new
    c.anchor = GridBagConstraints::NORTHWEST
    c.fill = GridBagConstraints::HORIZONTAL
    c.insets = Insets.new(5, 5, 5, 5)
    c.weightx = 2
    c.gridy = 0

    begin
      xmlContent = open(BioCatalogueClient.servicesEndpoint(
          'xml', SERVICES_PER_PAGE, @page, 'SOAP')).read
      xmlDocument = LibXMLJRuby::XML::Parser.string(xmlContent).parse
    rescue Exception => ex
      LOG.fatal "#{ex.class.name} - #{ex.message}\n" << ex.backtrace.join("\n")
      exit
    end
    
    @localServiceCache = []
    
    xmlDocument.root.each { |node|
      case node.name
        when 'results'
          serviceNodes = Utilities::XML.selectNodesWithNameFrom("service", node)
          serviceNodes.each { |node|
            attr = Utilities::XML.getAttributeFromNode("xlink:href", node)
            next if (service = Service.new(attr.value)).nil? # URI attribute
            
            @localServiceCache << (service)
            panel.add(ServiceListingPanel.new(service), c)
            c.gridy += 1
          }
        when 'statistics'
          statsNodes = Utilities::XML.getValidChildren(node)
          statsNodes.each { |node|
            case node.name
              when 'pages'
                @lastPage = node.content.to_i
            end # case
          }
      end # case
    } # xmlDocument.root.each
        
    return JScrollPane.new(panel)
  end # mainPanel
  
end

