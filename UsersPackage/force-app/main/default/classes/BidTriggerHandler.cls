public class BidTriggerHandler {

    public static void validate(List<Bid__c> bids) {
        // Reject all bids if multiple bids are being inserted
        if (bids.size() > 1) {
            for (Bid__c bid : bids) {
                bid.addError('Cannot add more than one bid at a time.');
            }
            return;
        }
        
        // Assign single bid to a variable
        Bid__c bid = bids[0];
        
        // Reject if bid.Price__c is lower than Max(Price__c) on parent auction
        Bid__c maxBid = [SELECT Price__c FROM Bid__c WHERE Auction__c=:bid.Auction__c ORDER BY Price__c DESC LIMIT 1];
        if (bid.Price__c <= maxBid.Price__c) {
            bid.Price__c.addError('New bid amount cannot be lower than the maximum bid amount.');
        }
        
        // Update parent auction, if less than one hour remaining until End_Date__c on time of insert, move End_Date__c to one hour from NOW()
        /*Auction parentAuction = [SELECT End_Date__c FROM Auction__c WHERE Id=bid.Auction__c];
        
        Datetime bidDateTime = Datetime.now();
        Datetime auctionEndDateTime = parentAuction.End_Date__c;
        Long bidTime = bidDateTime.getTime();
        Long auctionEndTime = auctionEndDateTime.getTime();
        Decimal ms = (Decimal) bidTime-auctionEndTime;
        Decimal hr = ms/1000/60/60;
        if ( (Datetime.now() - parentAuction.End_Date__c) <= )*/
    }
    
}