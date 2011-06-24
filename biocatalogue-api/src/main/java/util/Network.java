package util;

import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URL;

import org.apache.wink.client.ClientConfig;
import org.apache.wink.client.ClientResponse;
import org.apache.wink.client.RestClient;

public abstract class Network extends HttpURLConnection {

  public static final String HTTPS_PROTOCOL = "https";
  public static final String HTTP_PROTOCOL = "http";
  
  private static final int TIMEOUT = 10000;

  // --
  
  private Network(URL u) {
    super(u);
  }

  // --
  
  public final static boolean isReachable(URI uri) {
    try {
      ClientConfig config = new ClientConfig();
      config.connectTimeout(TIMEOUT);
      config.readTimeout(TIMEOUT);
      
      RestClient client = new RestClient(config);
      ClientResponse response = client.resource(uri).get();
      return response.getStatusCode() == HTTP_OK;
    } catch (Exception e) {
      return false;
    }
  }

}
