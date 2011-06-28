package models.interfaces.resources;

import models.interfaces.abstracts.AnnotatableEntity;
import models.interfaces.abstracts.ArchivableEntity;
import models.interfaces.abstracts.DescribedEntity;
import models.interfaces.abstracts.PartiallyLoadableEntity;
import models.interfaces.abstracts.TimeStampedEntity;

public interface SoapOperation extends AnnotatableEntity, DescribedEntity, ArchivableEntity, TimeStampedEntity, PartiallyLoadableEntity {

  public String getParameterOrder();

  public SoapIO[] getSoapInputs();

  public SoapIO[] getSoapOutputs();

}
