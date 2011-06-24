package models.jsonimpl;

import java.net.URI;

import models.interfaces.BioCatalogueClient;
import models.interfaces.BioCatalogueDetails;
import models.interfaces.constants.BioCatalogue;
import util.Network;
import exceptions.HostnameUnreachableException;

public class BioCatalogueClientImpl implements BioCatalogueClient {

  private BioCatalogueDetails _bioCatalogueDetails;
  private String _hostname;

  // --

  public BioCatalogueClientImpl() throws HostnameUnreachableException {
    init(BioCatalogue.DEFAULT_HOSTNAME);
  }

  public BioCatalogueClientImpl(String hostname) throws HostnameUnreachableException {
    init(hostname);
  }

  private void init(String hostname) throws HostnameUnreachableException {
    if (hostname == null)
      _hostname = BioCatalogue.DEFAULT_HOSTNAME;
    else
      _hostname = hostname;

    try {
      URI uri = new URI(Network.HTTP_PROTOCOL, _hostname, null, null);
      if (!Network.isReachable(uri)) throw new Exception();
    } catch (Exception e) {
      throw new HostnameUnreachableException("Hostname '" + _hostname + "' could not be reached.");
    }

    _bioCatalogueDetails = new BioCatalogueDetailsImpl(this);
  }

  // --

  public BioCatalogueDetails getBioCatalogueDetails() {
    return _bioCatalogueDetails;
  }

  public String getHostname() {
    return _hostname;
  }

}
