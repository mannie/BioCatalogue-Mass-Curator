package models.interfaces.resources;

import models.interfaces.abstracts.AnnotatableEntity;
import models.interfaces.abstracts.ArchivableEntity;
import models.interfaces.abstracts.DescribedEntity;
import models.interfaces.abstracts.SubmittedEntity;
import models.interfaces.abstracts.TimeStampedEntity;

public interface RestParameter extends AnnotatableEntity, DescribedEntity, SubmittedEntity, ArchivableEntity, TimeStampedEntity {

  public boolean getIsOptional();

  public String getComputationalType();

  public String getParamStyle();

  public String[] getConstrainedValues();

}
