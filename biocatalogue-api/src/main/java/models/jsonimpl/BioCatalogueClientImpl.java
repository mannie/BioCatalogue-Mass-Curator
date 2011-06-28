package models.jsonimpl;

import java.net.URI;
import java.util.ArrayList;
import java.util.HashMap;

import models.interfaces.BioCatalogueClient;
import models.interfaces.BioCatalogueDetails;
import models.interfaces.constants.BioCatalogueConstants;
import models.interfaces.constants.JSON;
import models.interfaces.resources.Service;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import util.Network;
import exceptions.HostnameUnreachableException;

public class BioCatalogueClientImpl implements BioCatalogueClient {

  private static final int INITIAL_CAPACITY_FOR_DATA_STRUCTURES = 255;
  
  // --
  
  private BioCatalogueDetails _bioCatalogueDetails;
  private String _hostname;
  
  private Service[] _servicesArray;
  private ArrayList<Service> _servicesList; 
  private HashMap<Integer, Service> _servicesMap;
  
  // --

  public BioCatalogueClientImpl() throws Exception {
    init(BioCatalogueConstants.DEFAULT_HOSTNAME);
  }

  public BioCatalogueClientImpl(String hostname) throws Exception {
    init(hostname);
  }

  private void init(String hostname) throws Exception {
    if (hostname == null)
      _hostname = BioCatalogueConstants.DEFAULT_HOSTNAME;
    else
      _hostname = hostname;

    try {
      URI uri = new URI(Network.HTTP_PROTOCOL, _hostname, null, null);
      if (!Network.isReachable(uri)) throw new Exception();
    } catch (Exception e) {
      throw new HostnameUnreachableException("Hostname '" + _hostname + "' could not be reached.");
    }

    _bioCatalogueDetails = new BioCatalogueDetailsImpl(this);
    
    initDataStructures();
  }

  private void initDataStructures() {
    _servicesList = new ArrayList<Service>(INITIAL_CAPACITY_FOR_DATA_STRUCTURES);
    _servicesMap = new HashMap<Integer, Service>(INITIAL_CAPACITY_FOR_DATA_STRUCTURES);
  }

  // --

  public BioCatalogueDetails getBioCatalogueDetails() {
    return _bioCatalogueDetails;
  }

  public String getHostname() {
    return _hostname;
  }

  // --
  
  public Service[] getServices() {
    if (_servicesList.isEmpty()) {
      try {
        String path = BioCatalogueConstants.SERVICES_PATH + BioCatalogueConstants.BL_JSON_EXTENSION;
        URI uri = new URI(Network.HTTP_PROTOCOL, _hostname, path, null);
        
        JSONObject json = Network.getDocument(uri);
        
        Service service;
        int id;
        String name, resource;
        String[] resourceComponents;
        for (Object item : (JSONArray)json.get(JSON.SERVICES)) {
          name = (String) ((JSONObject)item).get(JSON.NAME);
          
          resource = (String) ((JSONObject)item).get(JSON.RESOURCE);
          resourceComponents = resource.split("/");
          
          id = Integer.parseInt(resourceComponents[resourceComponents.length - 1]);
          
          service = new ServiceImpl(id, name);
          _servicesList.add(service);
          _servicesMap.put(new Integer(id), service);
        }

        _servicesArray = new Service[_servicesList.size()]; 
        _servicesList.toArray(_servicesArray);
      } catch (Exception e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
      }
    }

    return _servicesArray;
  }

  public Service getService(int id) {
    getServices();
    return _servicesMap.get(new Integer(id));
  }
  
  public Service[] reloadServices() {
    initDataStructures();
    return getServices();
  }
  
}
