package models.interfaces.resources;

import models.interfaces.abstracts.AnnotatableEntity;
import models.interfaces.abstracts.ArchivableEntity;
import models.interfaces.abstracts.DescribedEntity;
import models.interfaces.abstracts.DocURLAnnotatedEntity;
import models.interfaces.abstracts.SubmittedEntity;
import models.interfaces.abstracts.TimeStampedEntity;

public interface RestMethod extends AnnotatableEntity, DescribedEntity, DocURLAnnotatedEntity, SubmittedEntity, ArchivableEntity, TimeStampedEntity {

  public String getURLTemplate();

  public String getEndpointLabe();

  public String getHTTPMethodType();

  public RestParameter[] getInputParameters();

  public RestParameter[] getOutputParameters();

  public RestRepresentation[] getInputRepresentations();

  public RestRepresentation[] getOutputRepresentations();

}
