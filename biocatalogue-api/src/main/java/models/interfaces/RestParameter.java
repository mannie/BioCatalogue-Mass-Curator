package models.interfaces;

public interface RestParameter extends DescribedEntity, AnnotatableEntity, ArchivableEntity, TimeStampedEntity, SubmittedEntity {

  public boolean getIsOptional();

  public String getComputationalType();

  public String getParamStyle();

  public String[] getConstrainedValues();

}
