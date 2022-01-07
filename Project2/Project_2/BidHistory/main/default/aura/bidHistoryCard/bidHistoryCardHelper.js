({
    fetchResult: function(component) {
        const action = component.get("c.getResults");
        action.setParams({ auctionId: component.get("v.recordId") });
        action.setCallback(this, function(response) {
            const state = response.getState();
            if (state === "SUCCESS") {
                const resp = response.getReturnValue();
                //looping through each row of the result 
                console.log(resp);
                for (let row of resp) {
                    console.log(row.Contact__r.FirstName);
                    //as data columns with relationship __r can not be displayed directly in data table, so generating dynamic columns 
                    if (row.Contact__r) {
                        // assign the related data to new variables
                        row.FirstName = row.Contact__r.FirstName;
                        row.LastName = row.Contact__r.LastName;
                    }
                }
                //set returnValue to data attribute
                component.set("v.data", resp);
            }
        });
        $A.enqueueAction(action);

    }
})