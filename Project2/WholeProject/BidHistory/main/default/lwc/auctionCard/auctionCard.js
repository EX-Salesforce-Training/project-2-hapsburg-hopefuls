import { LightningElement, api, wire, track } from "lwc";
import AUCTION_TITLE_FIELD from "@salesforce/schema/Auction__c.Auction_Title__c";
import IMAGE_FIELD from "@salesforce/schema/Auction__c.Image__c";
import SHIPPING_COST_FIELD from "@salesforce/schema/Auction__c.Shipping_Cost__c";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class AuctionCard extends LightningElement {
    @api recordId;
    @track record;
    @api objectApiName;
    returnUrl;

    //exposing field to make them available to the template
    Auction_Title = AUCTION_TITLE_FIELD;
    Image = IMAGE_FIELD;
    Shipping_Cost = SHIPPING_COST_FIELD;

    connectedCallback() {
        this.record = sessionStorage.getItem("recordId");
        this.returnUrl = "/s/auction/" + this.record;
    }
}