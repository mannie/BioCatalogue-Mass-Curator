package models.interfaces.resources;

import models.interfaces.abstracts.AnnotatableEntity;
import models.interfaces.abstracts.ArchivableEntity;
import models.interfaces.abstracts.DescribedEntity;
import models.interfaces.abstracts.TimeStampedEntity;

public interface SoapIO extends AnnotatableEntity, DescribedEntity, ArchivableEntity, TimeStampedEntity {

  public String getComputationalType();

}
