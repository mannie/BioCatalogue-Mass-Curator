package models.interfaces;

import models.interfaces.abstracts.AnnotatableEntity;
import models.interfaces.abstracts.DescribedEntity;
import models.interfaces.abstracts.DocURLAnnotatedEntity;
import models.interfaces.abstracts.SubmittedEntity;
import models.interfaces.abstracts.TimeStampedEntity;

public interface RestMethod extends AnnotatableEntity, DescribedEntity, ArchivableEntity, TimeStampedEntity, SubmittedEntity, DocURLAnnotatedEntity {

  public String getURLTemplate();

  public String getEndpointLabe();

  public String getHTTPMethodType();

  public RestParameter[] getInputParameters();

  public RestParameter[] getOutputParameters();

  public RestRepresentation[] getInputRepresentations();

  public RestRepresentation[] getOutputRepresentations();

}
