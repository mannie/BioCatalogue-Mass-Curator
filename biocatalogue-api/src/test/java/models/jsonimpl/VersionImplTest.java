package models.jsonimpl;

import java.text.ParseException;

import junit.framework.Assert;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class VersionImplTest {

  private VersionImpl _version_1_0_3b;
  private VersionImpl _version_2_3_2beta;
  private VersionImpl _versionWithNullArg;
  private VersionImpl _versionWithEmptyString;
  private VersionImpl _version_1;
  private VersionImpl _version_1beta;
  private VersionImpl _version_1_0_2;
  private VersionImpl _version_1_3b;
  private VersionImpl _version_1_3;
  
  // --
  
  @Before
  public void setUp() throws Exception {
    _version_1_0_3b = new VersionImpl("1.0.3b");
    _version_2_3_2beta = new VersionImpl("2.3.2beta");
    
    _version_1_0_2 = new VersionImpl("1.0.2");
    
    _version_1_3b = new VersionImpl("1.3b");
    _version_1_3 = new VersionImpl("1.3");
    
    _version_1beta = new VersionImpl("1beta");
    _version_1 = new VersionImpl("1");
    
    try {
      _versionWithNullArg = new VersionImpl(null);
    } catch (IllegalArgumentException e) {
      _versionWithNullArg = null;
    }
    
    try {
      _versionWithEmptyString = new VersionImpl(" ");
    } catch (IllegalArgumentException e) {
      _versionWithEmptyString = null;
    }
  }

  @After
  public void tearDown() throws Exception {
    _version_1_0_3b = null;
    _version_2_3_2beta = null;
    
    _versionWithNullArg = null;
    _versionWithEmptyString = null;
    
    _version_1 = null;
    _version_1beta = null;
    _version_1_0_2 = null;
    _version_1_3b = null;
    _version_1_3 = null;
  }
  
  // --

  @Test
  public void testVersionImpl() {
    Assert.assertNotNull(_version_1_0_3b);
    Assert.assertNotNull(_version_2_3_2beta);
    
    Assert.assertNull(_versionWithNullArg);
    Assert.assertNull(_versionWithEmptyString);

    Assert.assertNotNull(_version_1);
    Assert.assertNotNull(_version_1beta);
    Assert.assertNotNull(_version_1_0_2);
    Assert.assertNotNull(_version_1_3b);
    Assert.assertNotNull(_version_1_3);
  }

  @Test
  public void testGetMajor() {
    Assert.assertEquals(1, _version_1_0_3b.getMajor());
    Assert.assertEquals(2, _version_2_3_2beta.getMajor());

    Assert.assertEquals(1, _version_1.getMajor());
    Assert.assertEquals(1, _version_1beta.getMajor());
    Assert.assertEquals(1, _version_1_0_2.getMajor());
    Assert.assertEquals(1, _version_1_3b.getMajor());
    Assert.assertEquals(1, _version_1_3.getMajor());
  }

  @Test
  public void testGetMinor() {
    Assert.assertEquals(0, _version_1_0_3b.getMinor());
    Assert.assertEquals(3, _version_2_3_2beta.getMinor());

    Assert.assertEquals(0, _version_1.getMinor());
    Assert.assertEquals(0, _version_1beta.getMinor());
    Assert.assertEquals(0, _version_1_0_2.getMinor());
    Assert.assertEquals(3, _version_1_3b.getMinor());
    Assert.assertEquals(3, _version_1_3.getMinor());
  }

  @Test
  public void testGetPatch() {
    Assert.assertEquals(3, _version_1_0_3b.getPatch());
    Assert.assertEquals(2, _version_2_3_2beta.getPatch());
  
    Assert.assertEquals(0, _version_1.getPatch());
    Assert.assertEquals(0, _version_1beta.getPatch());
    Assert.assertEquals(2, _version_1_0_2.getPatch());
    Assert.assertEquals(0, _version_1_3b.getPatch());
    Assert.assertEquals(0, _version_1_3.getPatch());
  }

  @Test
  public void testGetSeries() {
    Assert.assertTrue(_version_1_0_3b.getSeries().equals("b"));
    Assert.assertTrue(_version_2_3_2beta.getSeries().equals("beta"));
  
    Assert.assertNull(_version_1.getSeries());
    Assert.assertNull(_version_1_0_2.getSeries());
    Assert.assertNull(_version_1_3.getSeries());

    Assert.assertTrue(_version_1beta.getSeries().equals("beta"));
    Assert.assertTrue(_version_1_3b.getSeries().equals("b"));
}

  @Test
  public void testEqualsVersion() throws ParseException {
    Assert.assertTrue(_version_1_0_3b.equals(new VersionImpl(" 1.0.3b")));
    Assert.assertTrue(_version_2_3_2beta.equals(new VersionImpl(" 2.3.2beta ")));

    Assert.assertTrue(_version_1.equals(new VersionImpl("1")));
    Assert.assertTrue(_version_1beta.equals(new VersionImpl(" 1beta ")));
    Assert.assertTrue(_version_1_0_2.equals(new VersionImpl(" 1.0.2 ")));
    Assert.assertTrue(_version_1_3b.equals(new VersionImpl(" 1.3b")));
    Assert.assertTrue(_version_1_3.equals(new VersionImpl(" 1.3")));
}

  @Test
  public void testIsAfter() throws ParseException {
    Assert.assertTrue(_version_1_0_3b.isAfter(new VersionImpl("1")));
    Assert.assertTrue(_version_1_0_3b.isAfter(new VersionImpl("1.0")));
    Assert.assertTrue(_version_1_0_3b.isAfter(new VersionImpl("1.0.2")));
    Assert.assertFalse(_version_1_0_3b.isAfter(new VersionImpl("2")));
    Assert.assertFalse(_version_1_0_3b.isAfter(new VersionImpl("1.2")));
    Assert.assertFalse(_version_1_0_3b.isAfter(new VersionImpl("1.0.3a")));
    
    Assert.assertTrue(_version_2_3_2beta.isAfter(new VersionImpl("2")));
    Assert.assertTrue(_version_2_3_2beta.isAfter(new VersionImpl("2.3")));
    Assert.assertTrue(_version_2_3_2beta.isAfter(new VersionImpl("2.3.1")));
    Assert.assertFalse(_version_2_3_2beta.isAfter(new VersionImpl("3")));
    Assert.assertFalse(_version_2_3_2beta.isAfter(new VersionImpl("2.4")));
    Assert.assertFalse(_version_2_3_2beta.isAfter(new VersionImpl("2.3.2beta")));

    Assert.assertTrue(_version_1.isAfter(new VersionImpl("0.3")));
    Assert.assertTrue(_version_1.isAfter(new VersionImpl("0.0.1")));
    Assert.assertTrue(_version_1.isAfter(new VersionImpl("0.0.2beta")));
    Assert.assertFalse(_version_1.isAfter(new VersionImpl("1")));
    Assert.assertFalse(_version_1.isAfter(new VersionImpl("1.2")));
    Assert.assertFalse(_version_1.isAfter(new VersionImpl("1.0.3a")));
    
    Assert.assertTrue(_version_1beta.isAfter(new VersionImpl("0.1")));
    Assert.assertTrue(_version_1beta.isAfter(new VersionImpl("0.1.0")));
    Assert.assertFalse(_version_1beta.isAfter(new VersionImpl("1b")));
    Assert.assertFalse(_version_1beta.isAfter(new VersionImpl("1alpha")));  
  }

}
