package models.interfaces;

public interface Annotation extends IdentifiableEntity, TimeStampedEntity {

  public AnnotationSourceEntity getSource();

  public AnnotationAttribute getAttribute();

  public AnnotatableEntity getAnnotatable();

  public int getVersion();

  public AnnotationValue getValue();

}
