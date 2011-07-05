package org.biocatalogue.mass_curator;

import javax.swing.JFrame;

import models.interfaces.BioCatalogueClient;
import models.jsonimpl.BioCatalogueClientImpl;

import org.biocatalogue.mass_curator.ui.MainWindow;
import org.biocatalogue.mass_curator.util.GUIWidget;


/**
 * Hello world!
 * 
 */
public class AppLauncher {

  public static void main(String[] args) throws Exception {
    BioCatalogueClient client = new BioCatalogueClientImpl();
    
    MainWindow window = new MainWindow(client);
    window.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    GUIWidget.centerOnMainDisplay(window);
    window.setVisible(true);
    
  }

}
