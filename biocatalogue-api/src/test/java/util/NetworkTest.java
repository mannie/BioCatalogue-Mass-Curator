package util;

import junit.framework.Assert;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class NetworkTest {

  private static final String VALID_HOSTNAME = "SANDBOX.biocatalogue.Org";
  private static final String VALID_HOSTNAME_WITH_PROTOCOL = "http://" + VALID_HOSTNAME;
  private static final String INVALID_HOSTNAME = "STANDBOX" + VALID_HOSTNAME;
  private static final String VALID_HOSTNAME_WITH_UNSUPPORTED_PROTOCOL = "git://" + VALID_HOSTNAME;
  private static final String MALFORMED_HOSTNAME = VALID_HOSTNAME + VALID_HOSTNAME_WITH_PROTOCOL;

  // --

  @Before
  public void setUp() throws Exception {
  }

  @After
  public void tearDown() throws Exception {
  }

  // --

  @Test
  public void testIsReachable() {
    Assert.assertTrue(Network.isReachable(VALID_HOSTNAME));
    Assert.assertTrue(Network.isReachable(VALID_HOSTNAME_WITH_PROTOCOL));

    Assert.assertFalse(Network.isReachable(INVALID_HOSTNAME));
    Assert.assertFalse(Network.isReachable(VALID_HOSTNAME_WITH_UNSUPPORTED_PROTOCOL));

    Assert.assertFalse(Network.isReachable(MALFORMED_HOSTNAME));
  }

}
