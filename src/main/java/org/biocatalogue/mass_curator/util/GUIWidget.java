package org.biocatalogue.mass_curator.util;

import java.awt.Component;
import java.awt.Dimension;
import java.awt.Toolkit;

public abstract class GUIWidget {

  public static void centerOnMainDisplay(Component component) {
    Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();

    double x = (screenSize.getWidth() / 2) - (component.getWidth() / 2);
    double y = (screenSize.getHeight() / 2) - (component.getHeight() / 2);

    component.setLocation((int)x, (int)y);
  }

}
