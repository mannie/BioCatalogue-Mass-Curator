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
  
  attr_reader :serviceURIField, :localServiceCache
  
  SERVICES_PER_PAGE = 3
  
  def initialize(pageNumber)
    super()

    @page = pageNumber.to_i
    initUI
    
    return self
  end # initialize
  
private
  
  def initUI
    self.setLayout(BorderLayout.new)  
    
    self.add(searchPanel, BorderLayout::NORTH)
    self.add(mainPanel)
    
    self.add(nextPageButton = JButton.new(">"), BorderLayout::EAST)
    nextPageButton.addActionListener(LoadServicesAction.new(self, @page+1))
    nextPageButton.setEnabled(false) if @page==@lastPage
    
    self.add(previousPageButton = JButton.new("<"), BorderLayout::WEST)
    previousPageButton.addActionListener(LoadServicesAction.new(self, @page-1))
    previousPageButton.setEnabled(false) if @page==1
    
    self.add(buttonPanel, BorderLayout::SOUTH)
  end # initUI
  
  def searchPanel
    panel = JPanel.new
    panel.setLayout(GridBagLayout.new)    
    c = GridBagConstraints.new
    c.fill = GridBagConstraints::HORIZONTAL
    c.anchor = GridBagConstraints::EAST

    # text field
    c.gridx = 0
    c.weightx = 50
    @serviceURIField = JTextField.new(BioCatalogueClient.services_endpoint.to_s)
    panel.add(@serviceURIField, c)
        
    # preview button
    c.gridx = 1
    c.weightx = 1
    previewButton = JButton.new("Preview")
    previewButton.addActionListener(PreviewAction.new(self))
    panel.add(previewButton, c)
    
    return panel
  end
  
  def buttonPanel
    panel = JPanel.new

    subPanel = JPanel.new
    subPanel.setLayout(GridLayout.new)
    
    backButton = JButton.new("Back")
    backButton.addActionListener(GoBackAction.new(self))

    exportButton = JButton.new("Export")
    exportButton.addActionListener(GenerateSpreadsheetAction.new(self))

    subPanel.add(backButton)
    subPanel.add(exportButton)
    
    panel.add(subPanel)
    return panel
  end
  
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
      xmlContent = open(BioCatalogueClient.services_endpoint(
          'xml', SERVICES_PER_PAGE, @page)).read
      xmlDocument = LibXMLJRuby::XML::Parser.string(xmlContent).parse
    rescue Exception => ex
      LOG.fatal "#{ex.class.name} - #{ex.message}\n" << ex.backtrace.join("\n")
      exit
    end
    
    @localServiceCache = []
    
    xmlDocument.root.each { |node|
      case node.name
        when 'results'
          serviceNodes = node.children.select { |n| n.name == "service" }
          serviceNodes.each { |node|
            uriAttr = node.attributes.select { |a| "xlink:href"==a.name }[0]
            
            next if (service = Service.new(uriAttr.value)).nil?
            
            @localServiceCache << (service)
            panel.add(ServiceListingPanel.new(service), c)
            c.gridy += 1
          }
        when 'statistics'
          validNodes = node.children.reject { |n| n.name == "#text" }
          validNodes.each { |statsNode|
            case statsNode.name
              when 'pages'
                @lastPage = statsNode.content.to_i
            end # case
          }
      end # case
    } # xmlDocument.root.each
        
    return JScrollPane.new(panel)
  end # mainPanel
  
end

