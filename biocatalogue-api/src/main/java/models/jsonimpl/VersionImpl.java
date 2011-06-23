package models.jsonimpl;

import java.text.ParseException;

import models.interfaces.generic.Version;

public class VersionImpl implements Version {

  private static final String NON_WORD_CHARACTER_REGEX = "[^a-zA-Z0-9]+"; // TODO
  private static final String SERIES_FILTER_REGEX = "[0-9]+";
  
  // --
  
  private int _major;
  private int _minor;
  private int _patch;
  private String _series;

  // --
  
  public VersionImpl(String version) throws ParseException {
    if (version == null)
      throw new IllegalArgumentException("Version cannot be initialized using null.");
    
    if (version.trim().isEmpty())
      throw new IllegalArgumentException("Version cannot be initialized using empty string.");

    try {
      String[] components = version.replaceAll(" ", "").split(NON_WORD_CHARACTER_REGEX);
      if (components.length > 0) {
        _series = components[components.length - 1].replaceFirst(SERIES_FILTER_REGEX, "");

        switch (components.length) {
          case 3:
            _patch = Integer.parseInt(components[2].replaceAll(_series, ""));
          case 2:
            _minor = Integer.parseInt(components[1].replaceAll(_series, ""));
          case 1:
            _major = Integer.parseInt(components[0].replaceAll(_series, ""));
            break;
        }
        
        if (_series.isEmpty()) _series = null;
      }
    } catch (Exception e) {
      throw new ParseException("Version '" + version + "' could not be parsed", -1);
    }
  }

  // --
  
  public int getMajor() {
    return _major;
  }

  public int getMinor() {
    return _minor;
  }

  public int getPatch() {
    return _patch;
  }

  public String getSeries() {
    return _series;
  }

  // --
  
  public boolean equals(Version other) {
    return _major == other.getMajor() && _minor == other.getMinor() && _patch == other.getPatch() 
           && (_series == other.getSeries() || _series.equalsIgnoreCase(other.getSeries()));
  }

  public boolean isAfter(Version other) {
    if (_major > other.getMajor()) return true;
    
    if (_major == other.getMajor()) {
      if (_minor > other.getMinor()) return true;
    
      if (_minor == other.getMinor()) {
        if (_patch > other.getPatch()) return true;
      }
    }
    
    return false;  
  }

}
