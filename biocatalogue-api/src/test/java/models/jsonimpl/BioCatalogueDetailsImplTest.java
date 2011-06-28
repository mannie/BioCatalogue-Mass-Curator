package models.jsonimpl;

import junit.framework.Assert;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class BioCatalogueDetailsImplTest {

  private BioCatalogueDetailsImpl _details;
  private BioCatalogueDetailsImpl _detailsWithNullArg;

  // --

  @Before
  public void setUp() throws Exception {
    _details = new BioCatalogueDetailsImpl(new BioCatalogueClientImpl());

    try {
      _detailsWithNullArg = new BioCatalogueDetailsImpl(null);
    } catch (Exception e) {
      _detailsWithNullArg = null;
    }
  }

  @After
  public void tearDown() throws Exception {
    _details = null;
    _detailsWithNullArg = null;
  }

  // --

  @Test
  public void testBioCatalogueDetailsImpl() {
    Assert.assertNotNull(_details);
    Assert.assertNull(_detailsWithNullArg);
  }

  @Test
  public void testGetAPIVersion() {
    Assert.assertNotNull(_details.getAPIVersion());
    Assert.assertEquals(VersionImpl.class, _details.getAPIVersion().getClass());
  }

  @Test
  public void testGetSystemVersion() {
    Assert.assertNotNull(_details.getSystemVersion());
    Assert.assertEquals(VersionImpl.class, _details.getSystemVersion().getClass());
  }

}
