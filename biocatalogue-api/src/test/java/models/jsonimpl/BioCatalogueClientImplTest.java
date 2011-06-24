package models.jsonimpl;

import junit.framework.Assert;
import junit.framework.TestCase;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class BioCatalogueClientImplTest extends TestCase {

  private final static String VALID_HOSTNAME = "sandbox.biocatalogue.org";
  private final static String INVALID_HOSTNAME = "standbomb.biochatalogue.org";
  
  private BioCatalogueClientImpl _client;
  private BioCatalogueClientImpl _clientWithNullArg;
  private BioCatalogueClientImpl _clientWithValidHostname;
  private BioCatalogueClientImpl _clientWithInvalidHostname;

  // --

  @Before
  public void setUp() throws Exception {
    _client = new BioCatalogueClientImpl();
    _clientWithNullArg = new BioCatalogueClientImpl(null);
    _clientWithValidHostname = new BioCatalogueClientImpl(VALID_HOSTNAME);
    
    try {
      _clientWithInvalidHostname = new BioCatalogueClientImpl(INVALID_HOSTNAME);
    } catch (Exception e) {
      _clientWithInvalidHostname = null;
    }
  }

  @After
  public void tearDown() throws Exception {
    _client = null;
    _clientWithNullArg = null;
    _clientWithValidHostname = null;
    _clientWithInvalidHostname = null;
  }

  // --

  @Test
  public void testBioCatalogueClientImpl() {
    Assert.assertNotNull(_client);
    Assert.assertNotNull(_clientWithNullArg);
    Assert.assertNotNull(_clientWithValidHostname);

    Assert.assertNull(_clientWithInvalidHostname);
  }

  @Test
  public void testGetBioCatalogueDetails() {
    Assert.assertNotNull(_client.getBioCatalogueDetails());
    Assert.assertNotNull(_clientWithNullArg.getBioCatalogueDetails());
    Assert.assertNotNull(_clientWithValidHostname.getBioCatalogueDetails());
  }

  @Test
  public void testGetHostname() {
    Assert.assertNotNull(_client.getHostname());
    Assert.assertEquals(String.class, _client.getHostname().getClass());

    Assert.assertNotNull(_clientWithNullArg.getHostname());
    Assert.assertTrue(_clientWithNullArg.getHostname().equalsIgnoreCase(_client.getHostname()));

    Assert.assertNotNull(_clientWithValidHostname.getHostname());
    Assert.assertTrue(_clientWithValidHostname.getHostname().equalsIgnoreCase(VALID_HOSTNAME));
  }

}
