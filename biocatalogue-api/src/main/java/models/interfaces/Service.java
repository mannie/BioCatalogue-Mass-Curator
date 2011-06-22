package models.interfaces;

import models.interfaces.abstracts.AnnotatableEntity;
import models.interfaces.abstracts.DescribedEntity;
import models.interfaces.abstracts.SubmittedEntity;
import models.interfaces.abstracts.TimeStampedEntity;

public interface Service extends ArchivableEntity, TimeStampedEntity, DescribedEntity, AnnotatableEntity, SubmittedEntity {

  public Class[] getTechnologyTypes();

  public ServiceVariant[] getVariants();

  public ServiceVariant getServiceVersionInstance();

  public ServiceDeployment[] getServiceDeployments();

  public MonitoringStatus getLatestMonitoringStatus();

}
