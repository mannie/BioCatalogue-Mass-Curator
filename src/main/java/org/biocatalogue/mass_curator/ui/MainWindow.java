package org.biocatalogue.mass_curator.ui;

import java.awt.BorderLayout;
import java.awt.Dimension;

import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JTabbedPane;

import models.interfaces.BioCatalogueClient;

public class MainWindow extends JFrame {

  /**
   * 
   */
  private static final long serialVersionUID = -5670314340232576757L;
  
  private static final int MINIMUM_WIDTH = 640;
  private static final int MINIMUM_HEIGHT = 400;

  // --
  
  private final BioCatalogueClient _biocatalogueClient;

  private JTabbedPane _tabbedPane;  

  // --
  
  public MainWindow(BioCatalogueClient client) {
    super();
    
    _biocatalogueClient = client;
    
    initUI();
    
    // TODO add window listener
  }

  private void initUI() {
    this.setLayout(new BorderLayout());
    
    _tabbedPane = new JTabbedPane(JTabbedPane.BOTTOM);

    // add tabs to tabbed pane
    // TODO add icon to tabs
    _tabbedPane.addTab("Browse BioCatalogue", null, new ServiceBrowserTab(_biocatalogueClient), "Browse the BioCatalogue web services");
    _tabbedPane.addTab("Upload Spreadsheet", null, null, "Extract annotations from an Excel spreadsheet and upload them to the BioCatalogue");
    
    // add tabbed pane to frame
    this.getContentPane().add(_tabbedPane);
    
    // add a bit of space between the edge of the tabbed pane and the bottom of the frame
    this.getContentPane().add(new JLabel(" "), BorderLayout.SOUTH);
    
    this.setMinimumSize(new Dimension(MINIMUM_WIDTH, MINIMUM_HEIGHT));
    this.pack();
  }
  
  // --
  
}
