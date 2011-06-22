package models.interfaces.resources;

import models.interfaces.abstracts.AnnotatableEntity;
import models.interfaces.abstracts.DescribedEntity;
import models.interfaces.abstracts.TimeStampedEntity;

public interface SoapOperation extends AnnotatableEntity, TimeStampedEntity, DescribedEntity, ArchivableEntity {

  public String getParameterOrder();

  public SoapIO[] getSoapInputs();

  public SoapIO[] getSoapOutputs();

}
