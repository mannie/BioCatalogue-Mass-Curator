package models.interfaces;

import models.interfaces.abstracts.AnnotatableEntity;
import models.interfaces.abstracts.DescribedEntity;

public interface ServiceProvider extends AnnotatableEntity, DescribedEntity {

  public String[] getHostnames();

}
