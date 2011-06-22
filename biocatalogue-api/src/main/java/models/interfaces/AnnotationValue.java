package models.interfaces;

import models.interfaces.abstracts.IdentifiableEntity;

public interface AnnotationValue extends IdentifiableEntity {

  public String getContent();
  
  public String getType();

}
