package models.interfaces.resources;

import models.interfaces.abstracts.IdentifiableEntity;

public interface ResourceIndex {

  public String getSearchQuery();

  // --

  public int getNumberOfItemsPerPage();

  public int getTotalNumberOfItems();

  // --

  public int getCurrentPage();

  public int getNumberOfPages();

  // --

  public String getSortedBy();

  public String getSortOrder();

  // --
  
  public IdentifiableEntity[] getResults();

}
