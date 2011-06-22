package models.interfaces;

public interface ServiceDeployment extends LocatableEntity, AnnotatableEntity, TimeStampedEntity, SubmittedEntity {

  public ServiceProvider getProvider();

  public String getEndpoint();

  public ServiceVariant getProvidedVariant();

}
