public class AuctionTriggerHelper {
	
    public static void validateMinimumBid(List<Auction__c> newAuctions) {
    	for (Auction__c auction : newAuctions){
       		if(auction.Minimum_Bid__c < 1){
            	auction.addError('You cannot have a initial bid price less than $1');
         	}
    	}
    }
    
    public static void validateImageField(List<Auction__c> newAuctions) {
        for (Auction__c auction : newAuctions) {
            if(auction.Image__c != null && auction.Image__c.contains('<img src') == false) {
                auction.addError('this field must contain an image');
            } 
        }
    }
}