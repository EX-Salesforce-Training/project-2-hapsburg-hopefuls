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
        // Reject if bid.Price__ is lower than Starting Price on parent auction
        Bid__c maxBid;
        Auction__c auction;
        try {
            maxBid = [SELECT Price__c FROM Bid__c WHERE Auction__c=:bid.Auction__c ORDER BY Price__c DESC LIMIT 1];
            if (bid.Price__c <= maxBid.Price__c) {
                bid.addError(
                    String.format(
                        'New bid amount ({0}) cannot be lower than the maximum bid amount ({1}).',
                        new List<Object>{bid.Price__c, maxBid.Price__c}
                    )
                );
            }
        } catch (Exception e) {
            auction = [SELECT Minimum_Bid__c FROM Auction__c WHERE Id =: bid.Auction__c];
            if(bid.Price__c <= auction.Minimum_Bid__c) {
                bid.addError(
                    String.format(
                        'New bid amount ({0}) cannot be lower than the starting bid amount ({1}).',
                        new List<Object>{bid.Price__c, auction.Minimum_Bid__c}
                    )
                );
            }
        }
        
        // Update parent auction, if less than one hour remaining until End_Date__c on time of insert, move End_Date__c to one hour from NOW()
        Auction__c parentAuction = [SELECT End_Date__c FROM Auction__c WHERE Id=:bid.Auction__c];
        
        if(parentAuction.End_Date__c != null) {
            Datetime bidDateTime = Datetime.now();
            Datetime auctionEndDateTime = parentAuction.End_Date__c;
            Long bidTime = bidDateTime.getTime();
            Long auctionEndTime = auctionEndDateTime.getTime();
            Decimal ms = (Decimal) bidTime-auctionEndTime;
            Decimal hr = ms/1000/60/60;
            if ( ms <= 1.0 ) {
                parentAuction.End_Date__c = bidDateTime.addHours(1);
                update parentAuction;
            }
        }
    }
    
}