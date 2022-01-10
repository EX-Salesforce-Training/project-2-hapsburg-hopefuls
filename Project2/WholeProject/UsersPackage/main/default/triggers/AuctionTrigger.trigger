trigger AuctionTrigger on Auction__c (before insert) {

    Switch on Trigger.OperationType {
        when BEFORE_INSERT {
			AuctionTriggerHelper.validateMinimumBid(Trigger.new);
            AuctionTriggerHelper.validateImageField(Trigger.new);
        }
    }
}