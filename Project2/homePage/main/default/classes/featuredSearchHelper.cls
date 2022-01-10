public with sharing class featuredSearchHelper {
	
    @AuraEnabled(cacheable=true)
    public static list<Auction__c> getAuctionList(string searchKey){
        // Generate a usable search key
     	string sTempSearchKey = searchKey;
        Integer count = 0;
        System.debug('searchkey created');
        
        // create auction list to store search results
        list<Auction__c> lstAuction = new list<Auction__c>();
        System.debug('List created');
        
        //query auctions for all matching type records, only grabbing tags for testing
        for(Auction__c auc : [Select Auction_Title__c, Image__c, Product_Tags__c
                           from Auction__c
                            WHERE Product_Tags__c includes (:sTempSearchKey)]){
                                //Only add the first items until the featured list is full, then cycle to only add items with more bids.
                                if(lstAuction.size() <= 5){
                                    lstAuction.add(auc);
                                }
                                // After the list is full, start checking bid sizes.
                                else{
                                    // Count cycles the lstAuction value.
                                    count = 0;
                                    
                                    // For every auction on the List auction, compare the new auction against them. 
                                    // If the new auction has MORE RELATED BIDS than the current one
                                    // replace the currently selected object with the new one.
                                    for(Auction__c auct : lstAuction){
                                    if([SELECT COUNT()
                                       from Bid__c
                                       WHERE Auction__c = :auc.Id] > 
                                       [SELECT COUNT()
                                       FROM Bid__c
                                       WHERE Auction__c = :lstAuction.get(count).Id]){
                                           lstAuction.remove(count);
                                           lstAuction.add(auc);
                                           break;
                                       } 
                                    count++;
                                    }
                                }
                                
                                
                                System.debug('Added an item');
                            }
        

        // Return lstAuction of all featured products.
        System.debug('Returning List');
        return lstAuction;
    }
}