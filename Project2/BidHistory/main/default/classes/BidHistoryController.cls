public with sharing class BidHistoryController {
	@AuraEnabled(cacheable=true)
	public static List<Bid__c> getResults(String auctionId) {
	  //System.debug(auctionId);
						
	   List<Bid__c> results = [SELECT Contact__r.FirstName, Contact__r.LastName, Price__c, CreatedDate FROM Bid__c WHERE Auction__c =:auctionId ORDER BY Price__c DESC ];					 
			
		return results;
	}
			
}
