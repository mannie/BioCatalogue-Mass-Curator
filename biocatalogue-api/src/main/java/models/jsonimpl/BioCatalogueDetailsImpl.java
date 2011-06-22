package models.jsonimpl;

import models.interfaces.BioCatalogueClient;
import models.interfaces.BioCatalogueDetails;

public class BioCatalogueDetailsImpl implements BioCatalogueDetails {

  private BioCatalogueClient _client;

  // --

  public BioCatalogueDetailsImpl(BioCatalogueClient client) {
    _client = client;
  }

  // --

  public String getAPIVersion() {
    // TODO Auto-generated method stub
    return null;
  }

  public String getSystemVersion() {
    // TODO Auto-generated method stub
    return null;
  }

}
