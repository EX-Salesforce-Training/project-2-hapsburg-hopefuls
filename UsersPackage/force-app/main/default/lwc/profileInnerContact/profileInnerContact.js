import { LightningElement, wire } from 'lwc'
import getProfileWithFields from '@salesforce/apex/ProfileController.getProfileWithFields'

import { subscribe, unsubscribe, APPLICATION_SCOPE, MessageContext } from 'lightning/messageService'
import selectedVTab from '@salesforce/messageChannel/selectedVTab__c'

import CONTACT_OBJECT from '@salesforce/schema/Contact'
// Customer Contact fields
import FIRSTNAME_FIELD from '@salesforce/schema/Contact.FirstName'
import LASTNAME_FIELD from '@salesforce/schema/Contact.LastName'
import PHONE_FIELD from '@salesforce/schema/Contact.Phone'
import EMAIL_FIELD from '@salesforce/schema/Contact.Email'
// Customer Address fields
import MAILINGSTREET_FIELD from '@salesforce/schema/Contact.MailingStreet'
import MAILINGCITY_FIELD from '@salesforce/schema/Contact.MailingCity'
import MAILINGSTATE_FIELD from '@salesforce/schema/Contact.MailingState'
import MAILINGZIP_FIELD from '@salesforce/schema/Contact.MailingPostalCode'
import MAILINGCOUNTRY_FIELD from '@salesforce/schema/Contact.MailingCountry'
// Customer Payment fields
import CREDITCARDNUMBER_FIELD from '@salesforce/schema/Contact.Credit_Card_Number__c'
import CVC_FIELD from '@salesforce/schema/Contact.CVC__c'

const contactFields = [
    FIRSTNAME_FIELD.fieldApiName,
    LASTNAME_FIELD.fieldApiName,
    PHONE_FIELD.fieldApiName,
    EMAIL_FIELD.fieldApiName
]

const addressFields = [
    MAILINGSTREET_FIELD.fieldApiName,
    MAILINGCITY_FIELD.fieldApiName,
    MAILINGSTATE_FIELD.fieldApiName,
    MAILINGZIP_FIELD.fieldApiName,
    MAILINGCOUNTRY_FIELD.fieldApiName
]

const paymentFields = [
    CREDITCARDNUMBER_FIELD.fieldApiName,
    CVC_FIELD.fieldApiName
]

export default class ProfileInnerContact extends LightningElement {
    subscription = null
    vTab

    profileObj = CONTACT_OBJECT
    fields = []
    profile
    error

    @wire(MessageContext)
    messageContext

    @wire(getProfileWithFields, { fields: [...contactFields, ...addressFields, ...paymentFields] })
    fetchProfile({ error, data }) {
        if (data) {
            this.profile = data
            this.error = undefined
        } else if (error) {
            this.profile = undefined
            this.error = error
            console.error(error)
        }

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

    unsubscribeToMessageChannel() {
        unsubscribe(this.subscription)
    }

    // Handler for message received by component
    handleMessage(message) {
        this.vTab = message.vTab
        if (message.vTab === 'contact') this.fields = contactFields
        else if (message.vTab === 'address') this.fields = addressFields
        else if (message.vTab === 'payment') this.fields = paymentFields
        else this.fields = []
    }

    // Standard lifecycle hooks used to subscribe and unsubsubscribe to the message channel
    connectedCallback() {
        this.subscribeToMessageChannel()
    }

    disconnectedCallback() {
        this.unsubscribeToMessageChannel()
    }
}
