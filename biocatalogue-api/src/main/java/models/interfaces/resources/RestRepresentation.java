package models.interfaces.resources;

import models.interfaces.abstracts.AnnotatableEntity;
import models.interfaces.abstracts.DescribedEntity;
import models.interfaces.abstracts.SubmittedEntity;
import models.interfaces.abstracts.TimeStampedEntity;

public interface RestRepresentation extends ArchivableEntity, AnnotatableEntity, TimeStampedEntity, DescribedEntity, SubmittedEntity {

  public String getContentType();

}
