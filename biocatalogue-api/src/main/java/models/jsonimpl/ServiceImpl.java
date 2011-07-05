package models.jsonimpl;

import java.util.Date;

import models.interfaces.abstracts.IdentifiableEntity;
import models.interfaces.constants.BioCatalogueConstants;
import models.interfaces.resources.Annotation;
import models.interfaces.resources.Service;
import models.interfaces.resources.ServiceDeployment;
import models.interfaces.resources.helpers.MonitoringStatus;
import models.interfaces.resources.helpers.ServiceVariant;

public class ServiceImpl implements Service {

  private int _intIdentifier;
  private String _name;
  private String _stringIdentifier;

  // --
  
  public ServiceImpl(int id, String name) {
    _intIdentifier = id;
    _name = name;
  }

  public ServiceImpl(String id, String name) {
    _stringIdentifier = id;
    _name = name;
  }
  
  // --

  public Annotation[] getAnnotations() {
    // TODO Auto-generated method stub
    return null;
  }

  public int getIntIdentifier() {
    return _intIdentifier;
  }

  public String getStringIdentifier() {
    return _stringIdentifier;
  }

  public String getURLComponent() {
    return BioCatalogueConstants.SERVICES_RESOURCE;
  }

  public String getName() {
    return _name;
  }

  public String getDescription() {
    // TODO Auto-generated method stub
    return null;
  }

  public IdentifiableEntity getSubmitter() {
    // TODO Auto-generated method stub
    return null;
  }

  public Date getArchivedAt() {
    // TODO Auto-generated method stub
    return null;
  }

  public Date getCreatedAt() {
    // TODO Auto-generated method stub
    return null;
  }

  public String[] getTechnologyTypes() {
    // TODO Auto-generated method stub
    return null;
  }

  public ServiceVariant[] getVariants() {
    // TODO Auto-generated method stub
    return null;
  }

  public ServiceVariant getServiceVersionInstance() {
    // TODO Auto-generated method stub
    return null;
  }

  public ServiceDeployment[] getServiceDeployments() {
    // TODO Auto-generated method stub
    return null;
  }

  public MonitoringStatus getLatestMonitoringStatus() {
    // TODO Auto-generated method stub
    return null;
  }

  public boolean hasFullyLoaded() {
    // TODO Auto-generated method stub
    return false;
  }

  public void fetchMoreInfo() {
    // TODO Auto-generated method stub
    
  }

  // --
  
  public String toString() {
    return (_intIdentifier == 0? _stringIdentifier:_intIdentifier) + " - " + _name; 
  }
  
}
