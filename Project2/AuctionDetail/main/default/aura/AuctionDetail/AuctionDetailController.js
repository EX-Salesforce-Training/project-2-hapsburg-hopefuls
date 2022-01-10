({
    doInit: function (component, event, helper) {
        component.find("bidRecordCreator").getNewRecord(
            "Bid__c", // sObject type (objectApiName)
            null, // recordTypeId
            false, // skip cache?
            $A.getCallback(function () {
                var rec = component.get("v.newBid");
                var error = component.get("v.newBidError");
                if (error || rec === null) {
                    console.log("Error initializing record template: " + error);
                    return;
                }
                console.log("Record template initialized: " + rec.apiName);
            })
        );

        let auctionAction = component.get("c.getAuction");
        auctionAction.setParams({ recId: component.get("v.recordId") });
        auctionAction.setCallback(this, function (response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.Auction", response.getReturnValue());
            }
        });

        let userAction = component.get("c.getUser");
        userAction.setCallback(this, function (response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.User", response.getReturnValue());
            }
        });

        let bidAction = component.get("c.getBids");
        bidAction.setParams({ recId: component.get("v.recordId") });
        bidAction.setCallback(this, function (response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let bids = response.getReturnValue();
                bids.sort(function (a, b) {
                    return b.Price__c - a.Price__c;
                });
                component.set("v.highestBid", bids[0].Price__c);
                component.set("v.nextHighestBid", bids[0].Price__c + 1);
                component.set("v.numberOfBids", bids.length);
            }
        });

        $A.enqueueAction(auctionAction);
        $A.enqueueAction(userAction);
        $A.enqueueAction(bidAction);
    },
    handleBid: function (component, event, helper) {
        sessionStorage.setItem("recordId", component.get("v.recordId"));
        const message = { modalData: true };
        component.find("modalChannel").publish(message);
    },
    handleRedirect: function (component, event, helper) {
        sessionStorage.setItem("recordId", component.get("v.recordId"));
    },
    handleSaveBid: function (component, event, helper) {
        console.log("partially in");
        if (event.which == 13) {
            console.log("fully in");
            component.set("v.simpleNewBid.Auction__c", component.get("v.recordId"));
            component.set("v.simpleNewBid.Contact__c", component.get("v.User.Id"));
            component.find("bidRecordCreator").saveRecord(function (saveResult) {
                if (saveResult.state === "SUCCESS" || saveResult.state === "DRAFT") {
                    // record is saved successfully
                    var resultsToast = $A.get("e.force:showToast");
                    resultsToast.setParams({
                        title: "Saved",
                        message: "The record was saved."
                    });
                    resultsToast.fire();
                } else if (saveResult.state === "INCOMPLETE") {
                    // handle the incomplete state
                    console.log("User is offline, device doesn't support drafts.");
                } else if (saveResult.state === "ERROR") {
                    // handle the error state
                    console.log("Problem saving contact, error: " + JSON.stringify(saveResult.error));
                } else {
                    console.log(
                        "Unknown problem, state: " + saveResult.state + ", error: " + JSON.stringify(saveResult.error)
                    );
                }
            });
        }
    }
});
