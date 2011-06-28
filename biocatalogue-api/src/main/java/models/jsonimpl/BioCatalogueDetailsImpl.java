package models.jsonimpl;

import java.net.URI;
import java.text.ParseException;

import models.interfaces.BioCatalogueClient;
import models.interfaces.BioCatalogueDetails;
import models.interfaces.constants.JSONConstants;
import models.interfaces.generic.Version;
import net.sf.json.JSONObject;
import util.Network;

public class BioCatalogueDetailsImpl implements BioCatalogueDetails {

  private BioCatalogueClient _client;

  private Version _systemVersion;
  private Version _apiVersion;

  // --

  public BioCatalogueDetailsImpl(BioCatalogueClient client) throws Exception {
    if (client == null)
      throw new IllegalArgumentException("BioCatalogueClient cannot be null");

    _client = client;
    try {
      URI uri = new URI(Network.HTTP_PROTOCOL, _client.getHostname(), "/api", null);
      JSONObject json = Network.getDocument(uri);
      
      try {
        String version = (String) ((JSONObject)json.get(JSONConstants.BIOCATALOGUE)).get(JSONConstants.API_VERSION);
        _apiVersion = new VersionImpl(version);
      } catch (ParseException e) {
        _apiVersion = null;
        // TODO figure out what to do when given an incorrect version
      }

      try {
        String version = (String) ((JSONObject)json.get(JSONConstants.BIOCATALOGUE)).get(JSONConstants.VERSION);
        _systemVersion = new VersionImpl(version);
      } catch (ParseException e) {
        _systemVersion = null;
      }
      
    } catch (Exception e) {
      throw e;
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
