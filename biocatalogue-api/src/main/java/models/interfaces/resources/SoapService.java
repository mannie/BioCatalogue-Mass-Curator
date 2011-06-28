package models.interfaces.resources;

import models.interfaces.resources.helpers.ServiceVariant;

public interface SoapService extends ServiceVariant {

  public String getWSDLLocation();

}
