package models.interfaces.resources;

import models.interfaces.abstracts.AnnotatableEntity;
import models.interfaces.abstracts.ArchivableEntity;
import models.interfaces.abstracts.DescribedEntity;
import models.interfaces.abstracts.PartiallyLoadableEntity;
import models.interfaces.abstracts.SubmittedEntity;
import models.interfaces.abstracts.TimeStampedEntity;
import models.interfaces.resources.helpers.MonitoringStatus;
import models.interfaces.resources.helpers.ServiceVariant;

public interface Service extends AnnotatableEntity, DescribedEntity, SubmittedEntity, ArchivableEntity, TimeStampedEntity, PartiallyLoadableEntity {

  public String[] getTechnologyTypes();

  public ServiceVariant[] getVariants();

  public ServiceVariant getServiceVersionInstance();

  public ServiceDeployment[] getServiceDeployments();

  public MonitoringStatus getLatestMonitoringStatus();

}
