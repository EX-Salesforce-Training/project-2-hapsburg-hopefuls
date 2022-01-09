trigger BidTrigger on Bid__c (before insert) {
    Switch on Trigger.OperationType {
        when BEFORE_INSERT {
            BidTriggerHandler.validate(Trigger.new);
        }
    }
}