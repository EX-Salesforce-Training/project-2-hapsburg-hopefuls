import { LightningElement, track, api } from 'lwc';

import getProductList from '@salesforce/apex/featuredSearchHelper.getAuctionList';

import {ShowToastEvent} from 'lightning/platformShowToastEvent'
import SystemModstamp from '@salesforce/schema/Account.SystemModstamp';

export default class ProductFilter extends LightningElement {

    @track auctions;
    @api featured1 = "Electronics";
    @api sVal = this.featured1;

    connectedCallback() {
              this.sVal = this.featured1;

            getProductList({searchKey: this.sVal})
            .then(result => {this.auctions = result;})

            .catch(error => {const event = new ShowToastEvent({
                title: 'Error',
                variant: 'error',
                message: error.body.message,
            });
            this.dispatchEvent(event);
            this.auctions=null;
            });
        
    }

    handleClick() {
        const contentClick = new CustomEvent("contentclick", {
          detail: true
        })
      
        this.dispatchEvent(contentClick);
      }
      
      handleRightClick() {
        const card = this.template.querySelector(".slds-card");
        const contentContainer = this.template.querySelector(".container");
        let scrollDistance = card.clientWidth * 4.68;
        contentContainer.scrollLeft += scrollDistance;
      }
      
      handleLeftClick() {
        const card = this.template.querySelector(".slds-card");
        const contentContainer = this.template.querySelector(".container");
        let scrollDistance = card.clientWidth * 4.68;
        contentContainer.scrollLeft -= scrollDistance;
      }

}