package models.interfaces.abstracts;

public interface PartiallyLoadableEntity {

  public boolean hasFullyLoaded();
  
  public void fetchMoreInfo();
  
}
