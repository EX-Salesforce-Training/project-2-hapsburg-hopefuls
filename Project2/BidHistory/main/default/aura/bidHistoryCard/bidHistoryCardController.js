({
    doInit: function(component, event, helper) {
        const columns = [
            { label: 'FirstName', fieldName: 'FirstName', type: 'text' },
            { label: 'LastName', fieldName: 'LastName', type: 'text' },
            { label: 'Bid Price', fieldName: 'Price__c', type: 'Currency' },
            { label: 'Placed On', fieldName: 'CreatedDate', type: 'Date' },
        ];
        component.set("v.columns", columns);
        //get previous result

        helper.fetchResult(component);

    }


});