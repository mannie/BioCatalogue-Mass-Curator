package models.interfaces;

public interface RestMethod extends AnnotatableEntity, DescribedEntity, ArchivableEntity, TimeStampedEntity, SubmittedEntity, DocURLAnnotatedEntity {

  public String getURLTemplate();

  public String getEndpointLabe();

  public String getHTTPMethodType();

  public RestParameter[] getInputParameters();

  public RestParameter[] getOutputParameters();

  public RestRepresentation[] getInputRepresentations();

  public RestRepresentation[] getOutputRepresentations();

}
