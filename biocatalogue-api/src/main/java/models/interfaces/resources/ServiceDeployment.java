package models.interfaces.resources;

import models.interfaces.abstracts.AnnotatableEntity;
import models.interfaces.abstracts.LocatableEntity;
import models.interfaces.abstracts.SubmittedEntity;
import models.interfaces.abstracts.TimeStampedEntity;

public interface ServiceDeployment extends LocatableEntity, AnnotatableEntity, TimeStampedEntity, SubmittedEntity {

  public ServiceProvider getProvider();

  public String getEndpoint();

  public ServiceVariant getProvidedVariant();

}
