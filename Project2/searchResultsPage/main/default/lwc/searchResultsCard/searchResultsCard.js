import { LightningElement, api, track } from 'lwc';
import {
    subscribe,
    unsubscribe,
    APPLICATION_SCOPE,
    MessageContext,
    createMessageContext
} from 'lightning/messageService';
import getSearchResults from '@salesforce/apex/searchResultsPageController.getSearchResults'
import FILTER from '@salesforce/messageChannel/Filter__c';

export default class SearchResultsCard extends LightningElement {

    context = createMessageContext();
    subscription = null;
    @track filterValue;
    @track displayCards = [];

    connectedCallback() {
        let results = getSearchResults();
        results.then(res => {
            for(let i = 0; i < Object.keys(res).length; i++) {
                const newObj = Object.assign({display: true}, res[i]);
                this.displayCards.push(newObj);
            }
        })
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
        console.log(this.filterValue);
        for(let card of this.displayCards) {
            if(card.Product_Tags__c.includes(this.filterValue)) {
                card.display = true;
            } else {
                card.display = false;
            }
        }
    }
}