package models.interfaces;

public interface SoapOperation extends AnnotatableEntity, TimeStampedEntity, DescribedEntity, ArchivableEntity {

  public String getParameterOrder();

  public SoapIO[] getSoapInputs();

  public SoapIO[] getSoapOutputs();

}
