package util;

import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URL;

import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

import org.apache.wink.client.ClientConfig;
import org.apache.wink.client.ClientResponse;
import org.apache.wink.client.Resource;
import org.apache.wink.client.RestClient;

public abstract class Network extends HttpURLConnection {

  public static final String HTTPS_PROTOCOL = "https";
  public static final String HTTP_PROTOCOL = "http";
  
  private static final int CONNECT_TIMEOUT = 10000;
  private static final int READ_TIMEOUT = 10000;
  
  private static final String ACCEPT_JSON = "application/json";
  
  // --
  
  private Network(URL u) {
    super(u);
  }

  // --
  
  public final static boolean isReachable(URI uri) {
    try {
      ClientConfig config = new ClientConfig();
      config.connectTimeout(CONNECT_TIMEOUT);
      config.readTimeout(READ_TIMEOUT);
      
      RestClient client = new RestClient(config);
      ClientResponse response = client.resource(uri).get();
      return response.getStatusCode() == HTTP_OK;
    } catch (Exception e) {
      return false;
    }
  }

  public static JSONObject getDocument(URI uri) throws Exception {
    try {
      ClientConfig config = new ClientConfig();
      config.connectTimeout(CONNECT_TIMEOUT);
      config.readTimeout(READ_TIMEOUT);
      
      RestClient client = new RestClient(config);
      Resource resource = client.resource(uri);
      resource.accept(ACCEPT_JSON);
      
      ClientResponse response = resource.get();
      if (response.getStatusCode() == HTTP_OK) {
        JSONObject result = (JSONObject) JSONSerializer.toJSON(response.getEntity(String.class));
        return result;
      } else {
        throw new Exception(response.getMessage());
      }
    } catch (Exception e) {
      throw e;
    }
  }

}
