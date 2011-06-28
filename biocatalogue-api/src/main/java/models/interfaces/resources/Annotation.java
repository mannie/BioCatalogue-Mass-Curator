package models.interfaces.resources;

import models.interfaces.abstracts.AnnotatableEntity;
import models.interfaces.abstracts.AnnotationSourceEntity;
import models.interfaces.abstracts.IdentifiableEntity;
import models.interfaces.abstracts.TimeStampedEntity;
import models.interfaces.resources.helpers.AnnotationValue;

public interface Annotation extends IdentifiableEntity, TimeStampedEntity {

  public AnnotationSourceEntity getSource();

  public AnnotationAttribute getAttribute();

  public AnnotatableEntity getAnnotatable();

  public int getVersion();

  public AnnotationValue getValue();

}
