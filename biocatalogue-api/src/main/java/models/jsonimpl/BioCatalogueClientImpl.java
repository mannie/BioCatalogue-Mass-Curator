package models.jsonimpl;

import java.net.URI;
import java.util.ArrayList;
import java.util.HashMap;

import models.interfaces.BioCatalogueClient;
import models.interfaces.BioCatalogueDetails;
import models.interfaces.constants.BioCatalogueConstants;
import models.interfaces.constants.JSONConstants;
import models.interfaces.resources.Service;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import util.Network;
import exceptions.HostnameUnreachableException;

public class BioCatalogueClientImpl implements BioCatalogueClient {

  private static final int INITIAL_CAPACITY_FOR_DATA_STRUCTURES = 255;

  private static final int SERVICES_PER_PAGE = BioCatalogueConstants.SERVICES_PER_PAGE;
  
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
        for (Object item : (JSONArray)json.get(JSONConstants.SERVICES)) {
          name = (String) ((JSONObject)item).get(JSONConstants.NAME);
          
          resource = (String) ((JSONObject)item).get(JSONConstants.RESOURCE);
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
  
  public Service[] getServices(int pageNumber) {    
    if (pageNumber < 1) return new Service[0];
    
    getServices();
    // lastPage has been rounded up!
    int lastPage = (int) Math.round(_servicesArray.length / SERVICES_PER_PAGE + 0.5);
    if (pageNumber > lastPage) return new Service[0];
    
    // set starting point
    Service[] services = new Service[SERVICES_PER_PAGE];
    int lowerBound = pageNumber * SERVICES_PER_PAGE - SERVICES_PER_PAGE + 1; 
    
    // set stopping point
    int upperBound = SERVICES_PER_PAGE; 
    if (pageNumber == lastPage) {
      upperBound = pageNumber * SERVICES_PER_PAGE;
      
      int itemsOnPage = _servicesArray.length % SERVICES_PER_PAGE;
      if (itemsOnPage < SERVICES_PER_PAGE) upperBound = upperBound - SERVICES_PER_PAGE + itemsOnPage; 
    } else if (pageNumber > 1) {
      upperBound *= pageNumber; 
    }
    
    // get services
    int itemCount = upperBound - lowerBound + 1;
    for (int i = 0; i < itemCount; i++) {
      services[i] = _servicesArray[lowerBound + i - 1];
    }
    
    return services;
  }
  
  // --
  
  public Service[] reloadServices() {
    initDataStructures();
    return getServices();
  }
  
}
