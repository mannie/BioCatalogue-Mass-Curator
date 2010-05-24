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
  
  attr_reader :serviceURIField
  
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
    
    self.add(nextPageButton = JButton.new(">>"), BorderLayout::EAST)
    self.add(previousPageButton = JButton.new("<<"), BorderLayout::WEST)
    nextPageButton.addActionListener(LoadServicesAction.new(self, @page+1))
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
    panel.setLayout(GridLayout.new(0, 1))
    
    begin
      xml = open(BioCatalogueClient.services_endpoint('xml', 25, @page)).read
      xmlDocument = LibXMLJRuby::XML::Parser.string(xml).parse
    rescue Exception => ex
      LOG.fatal "#{ex.class.name} - #{ex.message}\n" << ex.backtrace.join("\n")
      exit
    end
    
    @serviceList = []
    
    xmlDocument.root.each { |node|
      case node.name
        when 'results'
          serviceNodes = node.children.select { |n| n.name == "service" }
          serviceNodes.each { |service| 
            @serviceList << (listing = generateServiceListing(service))
            
            panel.add(checkBox = JCheckBox.new(listing.to_s, false))
            checkBox.addChangeListener(CheckBoxListener.new(listing))
          }
        when 'statistics'
          LOG.warn "TODO: gather stats"
      end # case
    } # xmlDocument.root.each
        
    return JScrollPane.new(panel)
  end # mainPanel
  
  def generateServiceListing(serviceNode)
    begin
      service_id = serviceNode.attributes.select { |a| "xlink:href"==a.name }[0]
      service_id = service_id.value.split('/')[-1].to_i
    
      name, technology, description = '', '', ''
    
      propertyNodes = serviceNode.children.reject { |n| n.name == "#text" }
      propertyNodes.each do |propertyNode|
        case propertyNode.name
          when 'name'
            name = propertyNode.content
          when 'dc:description'
            description = propertyNode.content
          when 'serviceTechnologyTypes'
            technology = propertyNode.child.next.content
        end # case
      end # serviceNode.each

      listing = Service.new(service_id, name, technology, description)
    rescue Exception => ex
      LOG.error "#{ex.class.name} - #{ex.message}\n" << ex.backtrace.join("\n")
    end # begin rescue

    return listing
  end # generateServiceListing
  
end

