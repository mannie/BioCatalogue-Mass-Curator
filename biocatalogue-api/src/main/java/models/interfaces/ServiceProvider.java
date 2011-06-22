package models.interfaces;

public interface ServiceProvider extends AnnotatableEntity, DescribedEntity {

  public String[] getHostnames();

}
