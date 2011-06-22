package models.interfaces.resources;

import models.interfaces.abstracts.IdentifiableEntity;
import models.interfaces.abstracts.NamedEntity;

public interface AnnotationAttribute extends IdentifiableEntity, NamedEntity {

  public String getIdentifierURL();

}
