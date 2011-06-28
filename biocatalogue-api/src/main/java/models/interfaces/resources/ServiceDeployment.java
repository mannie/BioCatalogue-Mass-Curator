package models.interfaces.resources;

import models.interfaces.abstracts.AnnotatableEntity;
import models.interfaces.abstracts.LocatableEntity;
import models.interfaces.abstracts.SubmittedEntity;
import models.interfaces.abstracts.TimeStampedEntity;
import models.interfaces.resources.helpers.ServiceVariant;

public interface ServiceDeployment extends AnnotatableEntity, LocatableEntity, SubmittedEntity, TimeStampedEntity {

  public ServiceProvider getProvider();

  public String getEndpoint();

  public ServiceVariant getProvidedVariant();

}
