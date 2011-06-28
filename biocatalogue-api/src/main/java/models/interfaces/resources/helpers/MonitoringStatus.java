package models.interfaces.resources.helpers;

import java.util.Date;

import javax.swing.ImageIcon;

public interface MonitoringStatus {

  public ImageIcon getSymbol();

  public ImageIcon getSmallSymbol();

  public Date getLastChecked();

  public String getMessage();

  public String getLabel();

}
