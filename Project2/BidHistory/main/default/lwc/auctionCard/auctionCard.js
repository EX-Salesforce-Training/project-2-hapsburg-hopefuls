import { LightningElement, api, wire, track } from 'lwc';
import getAuctionDetail from '@salesforce/apex/BidHistoryController.getAuctionDetail';
import AUCTION_OBJECT from '@salesforce/schema/Auction__c';
import AUCTION_TITLE_FIELD from '@salesforce/schema/Auction__c.Auction_Title__c';
import IMAGE_FIELD from '@salesforce/schema/Auction__c.Image__c';
import SHIPPING_COST_FIELD from '@salesforce/schema/Auction__c.Shipping_Cost__c';
import { getFieldValue } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class AuctionCard extends LightningElement {
    @api recordId;
    @api objectApiName;

    //exposing field to make them available to the template
    Auction_Title = AUCTION_TITLE_FIELD;
    Image = IMAGE_FIELD;
    Shipping_Cost = SHIPPING_COST_FIELD;

    recordId = 'a005f000006jPdsAAE';

    handleSuccess(event) {
        const evt = new ShowToastEvent({
            title: "Feedback Submitted",
            message: "Success",
            variant: "success"
        });
        this.dispatchEvent(evt);
    }
}