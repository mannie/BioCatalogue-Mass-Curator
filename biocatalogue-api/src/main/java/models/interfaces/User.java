package models.interfaces;

import java.util.Date;

public interface User extends AnnotationSourceEntity, LocatableEntity {

  public Date getJoinedAt();
  
  public String getPublicEmail();
  
  public String getAffiliation();

}
