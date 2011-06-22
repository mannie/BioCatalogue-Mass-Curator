package models.interfaces;

import models.interfaces.abstracts.AnnotatableEntity;
import models.interfaces.abstracts.DescribedEntity;
import models.interfaces.abstracts.TimeStampedEntity;

public interface SoapIO extends ArchivableEntity, DescribedEntity, TimeStampedEntity, AnnotatableEntity {

  public String getComputationalType();

}
