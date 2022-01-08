({
    doInit: function (component, event, helper) {
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
                console.log("success");
                component.set("v.User", response.getReturnValue());
                console.log(response.getReturnValue());
            } else {
                console.log("failure");
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
        const message = { modalData: true };
        component.find("modalChannel").publish(message);
    }
});
