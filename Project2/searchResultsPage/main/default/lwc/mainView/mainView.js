import { LightningElement, wire } from 'lwc';
import getSearchResults from '@salesforce/apex/searchResultsPageController.getSearchResults'

export default class MainView extends LightningElement {

    @wire(getSearchResults)
    auctionList;

}