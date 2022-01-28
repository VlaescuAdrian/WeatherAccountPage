Public class AccountHelper{
                  
    @AuraEnabled
    Public static Account getAccount(String accId){
     
            try{
                Account acc = [SELECT Id, Name, BillingLatitude, BillingLongitude, BillingAddress, Weather__c FROM Account WHERE Id = :accId];
                Http h = new Http();

                
                String url = 'https://api.openweathermap.org/data/2.5/onecall?lat=' + acc.BillingLatitude + '&lon=' + acc.BillingLongitude + '&appid=337e5f163e9cb0dd80c7d8400a930977';
                HttpCalloutSample http = new HttpCalloutSample();
                HttpResponse res = http.getCalloutResponseContents(url);
                Map<String, object> jsonBody = (Map<String,object>) json.deserializeUntyped(res.getBody());
                Map<String, object> current = (Map<String,object>) jsonBody.get('current');
                List<object> weather = (List<object>) current.get('weather');
                Map<String, object> description  =(Map<String,object>) weather.get(0);

                acc.Weather__c = String.valueOf(description.get('description'));
                update acc;
                return acc;
            }
            catch(Exception ex){
                System.debug('An Exception: '+ex);
                return null;
            }
    }
    //update the account billing address with what you pass in the address form of the component
    @AuraEnabled
    Public static Integer changeAddressToAccount(String accId, String streetCh, String cityCh, String stateCh, String postalCodeCh, String countryCh){
     
            try{
                Account acc = [SELECT Id, BillingStreet,BillingCity,BillingState,BillingPostalCode,BillingCountry FROM Account WHERE Id = :accId];
                acc.BillingStreet = streetCh;
                acc.BillingCity = cityCh;
                acc.BillingState = stateCh;
                acc.BillingPostalCode = postalCodeCh;
                acc.BillingCountry = countryCh;
                update acc;

            }
            catch(Exception ex){
                System.debug('An Exception: '+ex);
                return 0;
            }
            return 0;

    }
} 
