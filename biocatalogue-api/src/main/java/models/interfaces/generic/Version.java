package models.interfaces.generic;

public interface Version {

  /**
   * 
   * @return the "X" component in "X.Y.Za"
   */
  public int getMajor();

  /**
   * 
   * @return the "Y" component in "X.Y.Za"
   */
  public int getMinor();

  /**
   * 
   * @return the "Z" component in "X.Y.Za"
   */
  public int getPatch();

  /**
   * Get any associated Greek letter for: alpha, beta, ...
   * 
   * @return the "a" component in "X.Y.Za"
   */
  public String getSeries();

  // --

  public boolean equals(Version other);

  public boolean isAfter(Version other);
  
}
