package models.interfaces;

public interface AnnotatableEntity extends IdentifiableEntity, NamedEntity {

  public Class getType();

  public Annotation[] getAnnotations();

}
