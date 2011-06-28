package models.interfaces.resources;

import models.interfaces.abstracts.AnnotatableEntity;
import models.interfaces.abstracts.ArchivableEntity;
import models.interfaces.abstracts.DescribedEntity;
import models.interfaces.abstracts.SubmittedEntity;
import models.interfaces.abstracts.TimeStampedEntity;

public interface RestRepresentation extends AnnotatableEntity, DescribedEntity, SubmittedEntity, ArchivableEntity, TimeStampedEntity {

  public String getContentType();

}
