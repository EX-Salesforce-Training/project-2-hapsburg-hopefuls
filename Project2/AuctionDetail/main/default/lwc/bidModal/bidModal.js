import { LightningElement, track, api } from "lwc";
import {
    subscribe,
    unsubscribe,
    APPLICATION_SCOPE,
    MessageContext,
    createMessageContext
} from "lightning/messageService";
import MODAL from "@salesforce/messageChannel/modalChannel__c";
import getUser from "@salesforce/apex/AuctionDetailApexController.getUser";
import getAuction from "@salesforce/apex/AuctionDetailApexController.getAuction";
import getBids from "@salesforce/apex/AuctionDetailApexController.getBids";
import { createRecord } from "lightning/uiRecordApi";

export default class BidModal extends LightningElement {
    @api recordId;
    @track displayModal = false;
    context = createMessageContext();
    subscription = null;
    @track user;
    @track auction;
    @track bids = [];
    highestBid;
    shippingCost;
    numberOfBids;
    button1amount;
    button2amount;
    button3amount;

    connectedCallback() {
        this.recordId = sessionStorage.getItem("recordId");
        console.log(this.recordId);
        let currentUser = getUser();
        currentUser.then((res) => (this.user = res));

        let currentAuction = getAuction({ recId: this.recordId });
        currentAuction.then((res) => {
            this.shippingCost = res.Shipping_Cost__c;
            this.auction = res;
        });

        let auctionBids = getBids({ recId: this.recordId });
        auctionBids.then((res) => {
            res.sort(function (a, b) {
                return b.Price__c - a.Price__c;
            });
            this.button1amount = res[0].Price__c + 1;
            this.button2amount = res[0].Price__c + 2;
            this.button3amount = res[0].Price__c + 3;
            this.highestBid = res[0].Price__c;
            this.numberOfBids = res.length;
            this.bids = res;
        });

        this.subscribeMC();
    }

    subscribeMC() {
        if (this.subscription) {
            return;
        } else {
            this.subscription = subscribe(
                this.context,
                MODAL,
                (message) => {
                    this.handleMessage(message);
                },
                { scope: APPLICATION_SCOPE }
            );
        }
    }

    handleMessage(message) {
        this.displayModal = message.modalData;
    }

    closeModal() {
        this.displayModal = false;
    }

    placeBidButton(event) {
        console.log("in the function");
        let bidModifier = parseInt(event.target.value);
        let bidPrice = this.bids[0].Price__c + bidModifier;
        let newBid = {
            apiName: "Bid__c",
            fields: {
                Price__c: bidPrice,
                Auction__c: this.auction.Id,
                Contact__c: this.user.Id
            }
        };
        this.displayModal = false;
        let create = createRecord(newBid);
        window.location.href = "/s/auction/" + this.recordId;
        alert("You have successfully placed a bid of US $" + bidPrice);
    }

    createNewBid(event) {
        let bidPrice = this.template.querySelector("input").value;
        console.log(bidPrice);
        if (!bidPrice || bidPrice <= this.bids[0].Price__c) {
            alert("Please enter a bid price above the current bid price");
        } else {
            let newBid = {
                apiName: "Bid__c",
                fields: {
                    Price__c: bidPrice,
                    Auction__c: this.auction.Id,
                    Contact__c: this.user.Id
                }
            };
            this.displayModal = false;
            let create = createRecord(newBid);
            window.location.href = "/s/auction/" + this.recordId;
            alert("You have successfully placed a bid of US $" + bidPrice);
        }
    }
}