package models.interfaces;

public interface Service extends ArchivableEntity, TimeStampedEntity, DescribedEntity, AnnotatableEntity, SubmittedEntity {

  public Class[] getTechnologyTypes();

  public ServiceVariant[] getVariants();

  public ServiceVariant getServiceVersionInstance();

  public ServiceDeployment[] getServiceDeployments();

  public MonitoringStatus getLatestMonitoringStatus();

}
