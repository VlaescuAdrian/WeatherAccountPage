# Weather Account Page

    * Created a simply lightning web component showed on the Account record page. The component works closely with the BillingAddress field of the Account.
    * Every time an account record page is loaded you will see 5 text area boxes with the current address of the account. 
    * The last text area will show the current weather based on the BillingLatitude and BillingLongitude of that Account. The value was received from calling an external api from openweather website. The key was generated on their site and I've put it hardcoded in the callout url. I've also  gave authorization for thei site URL in Salesforce. 
    * Every time you want to change the values on the component with another address and click the Change Button address, the weather will change and it will also update the BillingAddress address of the current account. If you change the BillingAddress of the account, the component will not show the current weather updated. The page needs to be refreshed to show the updated one. 
    * I've also let some console.logs in the code to see some responses from the API or the fields retreived from the current account.
    * There is an apex class with 2 methods that are querying the current account and changes the Weather field on the account.
    * There is a simple apex class that initiate an http call to a specific url that is being passed as a parameter.
    * As a last thing, a batch job class was created that updates the weather field based on the current latitude and longitude of the account.
    * In the scheduler, you will see the apex code that was run in the Develope Console to start the scheduled job that will run every hour. 
    * For weather, I've created a custom field as a text area that is populated with what we get from the Api response.
