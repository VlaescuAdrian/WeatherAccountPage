public class HttpCalloutSample {
    //method for creating a request and send it to a specific url(that has access from Salesforce)
    public HttpResponse getCalloutResponseContents(String url) {
  
      Http h = new Http();
  
      HttpRequest req = new HttpRequest();
      req.setEndpoint(url);
      req.setMethod('GET');
  
      HttpResponse res = h.send(req);
      return res;
    }
  }