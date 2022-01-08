({
    doInit: function (component, event, helper) {
        let auctionAction = component.get("c.getAuction");
        auctionAction.setParams({ recId: component.get("v.recordId") });
        auctionAction.setCallback(this, function (response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.Auction", response.getReturnValue());
                console.log("success");
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
        $A.enqueueAction(bidAction);
    }
});
