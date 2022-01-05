import { LightningElement, api, track } from 'lwc';
import {
    subscribe,
    unsubscribe,
    APPLICATION_SCOPE,
    MessageContext,
    createMessageContext
} from 'lightning/messageService';
import FILTER from '@salesforce/messageChannel/Filter__c';

export default class SearchResultsCard extends LightningElement {

    context = createMessageContext();
    subscription = null;
    @track filterValue;
    @api displayCards = [];

    connectedCallback() {
        this.subscribeMC();
    }

    subscribeMC() {
        if(this.subscription) {
            return;
        } else {
            this.subscription = subscribe(this.context, FILTER, (message) => {
                this.handleMessage(message)
            }, { scope: APPLICATION_SCOPE });
        }
    }

    handleMessage(message) {
        this.filterValue = message.filterData;
    }
}