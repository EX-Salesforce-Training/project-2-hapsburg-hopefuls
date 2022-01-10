import { LightningElement, wire, track } from 'lwc';
import getSearchResults from '@salesforce/apex/searchResultsPageController.getSearchResults'

export default class MainView extends LightningElement {

    @track auctionList = [];


    connectedCallback() {
        let results = getSearchResults();
        results.then(res => {
            let placeholder = res.map((item) => ({
                ...item,
                display: true
            }))
            return placeholder;
        })
        .then(data => {
            console.log(data);
        })
    }
}