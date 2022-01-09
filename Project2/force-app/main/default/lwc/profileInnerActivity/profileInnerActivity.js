import { LightningElement, wire, track } from 'lwc'
import getBids from '@salesforce/apex/BuyerController.getBids'

import { subscribe, unsubscribe, APPLICATION_SCOPE, MessageContext } from 'lightning/messageService'
import selectedVTab from '@salesforce/messageChannel/selectedVTab__c'

export default class ProfileInnerActivity extends LightningElement {
    subscription = null
    vTab

    @track bids
    error

    @wire(MessageContext)
    messageContext

    @wire(getBids)
    fetchBids({ error, data }) {
        if (data) {
            const bids = this.generateUrls(data)
            console.log(bids)
            this.bids = bids
            this.error = undefined           
        } else if (error) {
            this.bids = undefined
            this.error = error
            console.error(error)
        }
    }
    
    generateUrls(bids) {
        const newBids = []
        for (const bid of bids) {
            const newBid = { ...bid }
            newBid.url = `/s/auction/${bid.Auction__c}`
            newBids.push(newBid)
        }
        return newBids
    }

    //@wire(getAuctionDetails, {auctionIds})

    get isVTabBids() {
        return (this.vTab === 'bids')
    }

    get isVTabPurchases() {
        return (this.vTab === 'purchases')
    }

    subscribeToMessageChannel() {
        if (!this.subscription) {
            this.subscription = subscribe(
                this.messageContext,
                selectedVTab,
                (message) => this.handleMessage(message),
                { scope: APPLICATION_SCOPE }
            )
        }
    }
    
    unsubscribeToMessagechannel() {
        unsubscribe(this.subscription)
    }

    handleMessage(message) {
        this.vTab = message.vTab
    }

    connectedCallback() {
        this.subscribeToMessageChannel()
    }

    disconnectedCallback() {
        this.unsubscribeToMessagechannel()
    }
}