package models.interfaces;

public interface RestRepresentation extends ArchivableEntity, AnnotatableEntity, TimeStampedEntity, DescribedEntity, SubmittedEntity {

  public String getContentType();

}
