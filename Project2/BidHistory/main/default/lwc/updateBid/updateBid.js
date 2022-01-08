import { LightningElement, api, wire, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import BID_OBJECT from '@salesforce/schema/Bid__c';

export default class UpdateBid extends LightningElement {
    @api auctionId;
    @api contactId;
    @api recordId;


    handleSuccess(event) {
        const evt = new ShowToastEvent({
            title: "Bid Submitted",
            message: "Success",
            variant: "success"
        });
        this.dispatchEvent(evt);
    }
}