package models.jsonimpl;

import junit.framework.Assert;
import junit.framework.TestCase;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class BioCatalogueClientImplTest extends TestCase {

  private final static String VALID_HOSTNAME = "sandbox.biocatalogue.org";
  private final static String INVALID_HOSTNAME = "standbomb.biochatalogue.org";
  
  private static final int INVALID_SERVICE_ID = 1;
  private static final int VALID_SERVICE_ID = 2046;
  private static final String VALID_SERVICE_NAME = "BioQuali";
  
  // --
  
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

  @Test
  public void testGetServices() {
    Assert.assertNotNull(_client.getServices());
    Assert.assertTrue(_client.getServices().length > 0);
    Assert.assertTrue(_client.getServices().length > 1000);
    Assert.assertEquals(ServiceImpl.class, _client.getServices()[0].getClass());
    
    Assert.assertNotNull(_clientWithNullArg.getServices());
    Assert.assertTrue(_clientWithNullArg.getServices().length > 0);
    Assert.assertTrue(_clientWithNullArg.getServices().length > 1000);
    Assert.assertEquals(ServiceImpl.class, _clientWithNullArg.getServices()[0].getClass());
    
    Assert.assertNotNull(_clientWithValidHostname.getServices());
    Assert.assertTrue(_clientWithValidHostname.getServices().length > 0);
    Assert.assertTrue(_clientWithValidHostname.getServices().length > 1000);
    Assert.assertEquals(ServiceImpl.class, _clientWithValidHostname.getServices()[0].getClass());
  }
  
  @Test
  public void testGetService() {
    Assert.assertNull(_client.getService(INVALID_SERVICE_ID));
    Assert.assertNotNull(_client.getService(VALID_SERVICE_ID));
    Assert.assertTrue(_client.getService(VALID_SERVICE_ID).getName().equals(VALID_SERVICE_NAME));

    Assert.assertNull(_clientWithNullArg.getService(INVALID_SERVICE_ID));
    Assert.assertNotNull(_clientWithNullArg.getService(VALID_SERVICE_ID));
    Assert.assertTrue(_clientWithNullArg.getService(VALID_SERVICE_ID).getName().equals(VALID_SERVICE_NAME));
    
    Assert.assertNull(_clientWithValidHostname.getService(INVALID_SERVICE_ID));
    Assert.assertNotNull(_clientWithValidHostname.getService(VALID_SERVICE_ID));
    Assert.assertTrue(_clientWithValidHostname.getService(VALID_SERVICE_ID).getName().equals(VALID_SERVICE_NAME));
  }
  
}
