package models.jsonimpl;

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

    if (!Network.isReachable(_hostname))
      throw new HostnameUnreachableException();

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
