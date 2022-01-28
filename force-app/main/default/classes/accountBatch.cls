global class accountBatch implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful{
   
    global Database.QueryLocator start(Database.BatchableContext bc){
       
        String query = 'SELECT Id, Name, BillingLatitude, BillingLongitude, BillingAddress, Weather__c FROM Account';
        return Database.getQueryLocator(query);
    }
    //execute method to get the weather for all the accounts(it will be scheduled hourly)
    global void execute(Database.BatchableContext bc, List<account> scope) {
       

        for(Account acc : scope) {
            Http h = new Http();

            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://api.openweathermap.org/data/2.5/onecall?lat=' + acc.BillingLatitude + '&lon=' + acc.BillingLongitude + '&appid=337e5f163e9cb0dd80c7d8400a930977');
            req.setMethod('GET');
            HttpResponse res = h.send(req);
            Map<String, object> jsonBody = (Map<String,object>) json.deserializeUntyped(res.getBody());

            Map<String, object> current = (Map<String,object>) jsonBody.get('current');

            List<object> weather = (List<object>) current.get('weather');
            Map<String, object> description  =(Map<String,object>) weather.get(0);

            acc.Weather__c = String.valueOf(description.get('description'));
            
        }
        update scope;
    } 
       
    global void finish(Database.BatchableContext bc) {
       
    }
}