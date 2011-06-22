package models.interfaces.resources;

import java.util.Date;

import models.interfaces.abstracts.AnnotationSourceEntity;
import models.interfaces.abstracts.LocatableEntity;

public interface User extends AnnotationSourceEntity, LocatableEntity {

  public Date getJoinedAt();
  
  public String getPublicEmail();
  
  public String getAffiliation();

}
