package models.interfaces.constants;

public interface BioCatalogueConstants {

  // TODO: use live site as the default hostname
  public static final String DEFAULT_HOSTNAME = "sandbox.biocatalogue.org";
  
  public static final String SERVICES_RESOURCE = "services";
  public static final String SERVICES_PATH = "/" + SERVICES_RESOURCE;

  public static final String BL_JSON = "bljson";
  public static final String BL_JSON_EXTENSION = "." + BL_JSON;

  public static final int SERVICES_PER_PAGE = 10;

}
