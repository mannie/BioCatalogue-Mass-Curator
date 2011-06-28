package util;

import static org.junit.Assert.fail;

import java.net.URI;

import junit.framework.Assert;
import net.sf.json.JSONObject;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class NetworkTest {

  private static final String REACHABLE_HOSTNAME = "SANDBOX.biocatalogue.Org";
  private static final String UNREACHABLE_HOSTNAME = "STANDBOX" + REACHABLE_HOSTNAME;

  private URI _reachableURI;
  private URI _unreachableURI;

  // --

  @Before
  public void setUp() throws Exception {
    _reachableURI = new URI(Network.HTTP_PROTOCOL, REACHABLE_HOSTNAME, null, null);
    _unreachableURI = new URI(Network.HTTPS_PROTOCOL, UNREACHABLE_HOSTNAME, null, null);
  }

  @After
  public void tearDown() throws Exception {
    _reachableURI = null;
    _unreachableURI = null;
  }

  // --

  @Test
  public void testIsReachable() {
    Assert.assertTrue(Network.isReachable(_reachableURI));
    Assert.assertFalse(Network.isReachable(_unreachableURI));
  }

  @Test
  public void testGetDocument() throws Exception {
    JSONObject document = Network.getDocument(_reachableURI);
    Assert.assertNotNull(document);
    Assert.assertEquals(JSONObject.class, document.getClass());

    try {
      Network.getDocument(_unreachableURI);
      fail("URI was reachable when it should not have been: " + _unreachableURI);
    } catch (Exception e) {
      // do nothing, this is accepted
    }
  }

}
