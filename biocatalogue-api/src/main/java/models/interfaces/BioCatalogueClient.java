package models.interfaces;

import models.interfaces.resources.Service;

public interface BioCatalogueClient {

  public BioCatalogueDetails getBioCatalogueDetails();

  public String getHostname();

  // --
  
  public Service[] getServices();
  
  public Service getService(int id);
                 
}
