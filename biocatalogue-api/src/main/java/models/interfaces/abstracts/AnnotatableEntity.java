package models.interfaces.abstracts;

import models.interfaces.resources.Annotation;

public interface AnnotatableEntity extends IdentifiableEntity, NamedEntity {

  public Class getType();

  public Annotation[] getAnnotations();

}