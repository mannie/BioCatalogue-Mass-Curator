package org.biocatalogue.mass_curator.ui;

import java.awt.BorderLayout;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.beans.PropertyChangeEvent;
import java.beans.PropertyChangeListener;

import javax.swing.BorderFactory;
import javax.swing.JButton;
import javax.swing.JPanel;
import javax.swing.JSplitPane;
import javax.swing.JTextField;

import models.interfaces.BioCatalogueClient;

public class ServiceBrowserTab extends JPanel implements PropertyChangeListener {

  /**
   * 
   */
  private static final long serialVersionUID = 4046047606185582993L;

  private static final int MINIMUM_DIVIDER_LOCATION = 250;
  
  // --
  
  private final BioCatalogueClient _biocatalogueClient;

  private JTextField _searchField;
  private JButton _searchButton;

  private JSplitPane _splitPane;

  // --
  
  public ServiceBrowserTab(BioCatalogueClient client) {
    super();
    
    _biocatalogueClient = client;
    
    initUI();
  }

  private void initUI() {
    this.setLayout(new BorderLayout());
    
    // add search panel
    JPanel searchPanel = new JPanel(new GridBagLayout());
    searchPanel.setBorder(BorderFactory.createEtchedBorder());
    
    // default gridbag constraints
    GridBagConstraints c = new GridBagConstraints();
    c.fill = GridBagConstraints.HORIZONTAL;
    c.anchor = GridBagConstraints.EAST;

    // search (text) field
    c.gridx = 0;
    c.weightx = 50;
    searchPanel.add(_searchField = new JTextField(), c);
    _searchField.setHorizontalAlignment(JTextField.CENTER);
//    _searchField.addKeyListener(this); // TODO add key listener
          
    // search button
    c.gridx = 1;
    c.weightx = 1;
    _searchButton = new JButton("Search");
//    _searchButton.addActionListener(this); // TODO add action listener
    searchPanel.add(_searchButton, c);

    // add search panel to main container
    this.add(searchPanel, BorderLayout.NORTH);
    
    // the service browser; list in left pane, content in right pane 
    JPanel serviceDetailPanel = new JPanel(); 
    ServiceListPanel serviceListPanel = new ServiceListPanel(_biocatalogueClient, serviceDetailPanel);
    
    _splitPane = new JSplitPane(JSplitPane.HORIZONTAL_SPLIT, serviceListPanel, serviceDetailPanel);
    _splitPane.setDividerLocation(MINIMUM_DIVIDER_LOCATION);
    
    _splitPane.addPropertyChangeListener(this);
    
    this.add(_splitPane);
  }

  // --
  
  public void propertyChange(PropertyChangeEvent e) {
    if (e.getSource() == _splitPane) {
      if (_splitPane.getDividerLocation() < MINIMUM_DIVIDER_LOCATION)
        _splitPane.setDividerLocation(MINIMUM_DIVIDER_LOCATION);
    }
    
  }  
  
}
