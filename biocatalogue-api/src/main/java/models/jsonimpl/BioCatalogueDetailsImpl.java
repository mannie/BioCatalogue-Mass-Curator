package models.jsonimpl;

import java.text.ParseException;

import models.interfaces.BioCatalogueClient;
import models.interfaces.BioCatalogueDetails;
import models.interfaces.generic.Version;

public class BioCatalogueDetailsImpl implements BioCatalogueDetails {

  private BioCatalogueClient _client;

  private Version _systemVersion;
  private Version _apiVersion;

  // --

  public BioCatalogueDetailsImpl(BioCatalogueClient client) {
    if (client == null)
      throw new IllegalArgumentException("BioCatalogueClient cannot be null");

    _client = client;

    // TODO set _apiVersion and _systemVersion
    try {
      _apiVersion = new VersionImpl(null);
    } catch (ParseException e) {
      _apiVersion = null;
      
      // TODO figure out what to do when given an incorrect version
      e.printStackTrace();
    }
    
    try {
      _systemVersion = new VersionImpl(null);
    } catch (ParseException e) {
      _systemVersion = null;
      
      // TODO Auto-generated catch block
      e.printStackTrace();
    }
  }

  // --

  public Version getAPIVersion() {
    return _apiVersion;
  }

  public Version getSystemVersion() {
    return _systemVersion;
  }

}
