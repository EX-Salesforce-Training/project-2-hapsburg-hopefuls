import { LightningElement, wire, api } from 'lwc';
import getSearchResults from '@salesforce/apex/searchResultsPageController.getSearchResults';

export default class FilterBar extends LightningElement {
    
    @api searchResults = [];

    get options() {
        return [
            { label: 'Sales', value: 'option1' },
            { label: 'Force', value: 'option2' },
        ];
    }

}