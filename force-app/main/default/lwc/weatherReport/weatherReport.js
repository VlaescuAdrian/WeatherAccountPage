import { 
    LightningElement,
    api,
    track 
} from 'lwc';

import getAccountId from "@salesforce/apex/AccountHelper.getAccount";
import changeAddress from "@salesforce/apex/AccountHelper.changeAddressToAccount";
  
  
export default class WeatherReport extends LightningElement {
    @api recordId;
    @track weather;

    @track street;
    @track city;
    @track state;
    @track postalCode;
    @track country;

    @track errorMessage = false;

    clickedButtonLabel;

    handle_street_change(event) {
        this.street = event.detail.value;
    }
    handle_city_change(event) {
        this.city = event.detail.value;
    }
    handle_state_change(event) {
        this.state = event.detail.value;
    }
    handle_code_change(event) {
        this.postalCode = event.detail.value;
    }
    handle_country_change(event) {
        this.country = event.detail.value;
    }
    set_address(addressParam) {
        this.street = addressParam.BillingAddress.street;
        this.city = addressParam.BillingAddress.city;
        this.state = addressParam.BillingAddress.state;
        this.postalCode = addressParam.BillingAddress.postalCode;
        this.country = addressParam.BillingAddress.country;
    }
  
    connectedCallback(){
        getAccountId({ 
            accId : this.recordId, 
        })
        .then(result => {
            console.log(result);
            if (result === null){
                this.weather = 'Please fill in the address to find the proper weather';
            } else {
                this.weather = result.Weather__c;
                this.set_address(result);
            }
        })
        .catch(error => {
        });
   }

    handleClick(event) {
        this.clickedButtonLabel = event.target.label;
        if ((this.street == '' || this.street === undefined) && (this.city == '' || this.city === undefined) && (this.state == '' || this.state === undefined)
        && (this.postalCode == '' || this.postalCode === undefined) && (this.country == '' || this.country === undefined)) {
            this.errorMessage = true;
        } else {
            this.errorMessage = false;
            changeAddress({ 
                accId : this.recordId,
                streetCh : this.street,
                cityCh : this.city,
                stateCh : this.state,
                postalCodeCh : this.postalCode,
                countryCh : this.country
            })
            .then(result => {
                console.log(result);
            })
            .catch(error => {
            });
        }

        setTimeout(() => {
            getAccountId({ 
                accId : this.recordId, 
            })
            .then(result => {
                console.log(result);
                if (result === null){
                    this.weather = 'Please fill in the address to find the proper weather';
                } else {
                    this.weather = result.Weather__c;
                    this.set_address(result);
                }
            })
            .catch(error => {
            });
        }, 1000);

    }
}