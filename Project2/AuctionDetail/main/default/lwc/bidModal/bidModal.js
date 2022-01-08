import { LightningElement, track } from "lwc";
import {
    subscribe,
    unsubscribe,
    APPLICATION_SCOPE,
    MessageContext,
    createMessageContext
} from "lightning/messageService";
import MODAL from "@salesforce/messageChannel/modalChannel__c";

export default class BidModal extends LightningElement {
    @track test = false;
    context = createMessageContext();
    subscription = null;

    connectedCallback() {
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
        this.test = message.modalData;
        console.log(this.test);
    }

    closeModal() {
        this.test = false;
    }
}
