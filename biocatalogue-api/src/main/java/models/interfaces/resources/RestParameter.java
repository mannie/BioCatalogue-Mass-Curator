package models.interfaces.resources;

import models.interfaces.abstracts.AnnotatableEntity;
import models.interfaces.abstracts.DescribedEntity;
import models.interfaces.abstracts.SubmittedEntity;
import models.interfaces.abstracts.TimeStampedEntity;

public interface RestParameter extends DescribedEntity, AnnotatableEntity, ArchivableEntity, TimeStampedEntity, SubmittedEntity {

  public boolean getIsOptional();

  public String getComputationalType();

  public String getParamStyle();

  public String[] getConstrainedValues();

}
