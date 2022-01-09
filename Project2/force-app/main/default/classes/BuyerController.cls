public without sharing class BuyerController {
	@AuraEnabled(cacheable=true)
    public static List<Object> getBids() {
        Contact customer = ProfileController.getProfile();
        AggregateResult[] customerBids = getCustomerBids(customer);
        List<Id> auctionIds = new List<Id>();
        for (AggregateResult customerBid : customerBids) {
            // Casts the AggregateResult Object to Id
            auctionIds.add((Id) customerBid.get('Auction__c'));
        }
        AggregateResult[] maxBids = getMaxBids(auctionIds);
        
        List<Map<String, Object>> bidsMapList = combineBids(customerBids, maxBids);
        bidsMapList = appendAuctionInfo(bidsMapList);
        System.debug(bidsMapList);
        
        return bidsMapList;
    }
    
    public static List<AggregateResult> getCustomerBids(Contact customer) {
        AggregateResult[] customerBids = [SELECT Auction__c, MAX(Price__c) CustomerBid, MAX(Id) Id
                                  FROM Bid__c WHERE Contact__c=:customer.Id
                                  GROUP By Auction__c];
        return customerBids;
    }
    
    public static List<AggregateResult> getMaxBids(List<Id> AuctionIds) {
        AggregateResult[] maxBids = [SELECT Auction__c, MAX(Price__c) MaxBid, MAX(Contact__c) MaxBid_Contact__c
                                     FROM Bid__c WHERE Auction__c=:auctionIds
                                     GROUP By Auction__c];
        return maxBids;
    }
    
    public static List<Map<String, Object>> combineBids(List<sObject> bidsA, List<sObject> bidsB) {
        if (bidsA.size() == bidsB.size()) {
            List<Map<String, Object>> combinedMaps = new List<Map<String, Object>>();
            for (Integer i = 0; i < bidsA.size(); i++) {
           		sObject bidA = bidsA[i];
                sObject bidB = bidsB[i];
                Map<String, Object> bidAMap = bidA.getPopulatedFieldsAsMap();
                Map<String, Object> bidBMap = bidB.getPopulatedFieldsAsMap();
                
                // New combination map is required, as source maps are read-only
                Map<String, Object> combinedMap = new Map<String, Object>();
                combinedMap.putAll(bidAMap);
                combinedMap.putAll(bidBMap);
                combinedMaps.add(combinedMap);
            }
            return combinedMaps;
        } else {
            return null;
        }
    }
    
    public static List<Map<String, Object>> appendAuctionInfo(List<Map<String, Object>> bidsMapList) {
        List<Id> bidIds = new List<Id>();
        for (Map<String, Object> bidsMap : bidsMapList) {
            Id bidId = (Id) bidsMap.get('Id');
            bidIds.add(bidId);
        }
        List<Bid__c> auctionList = [SELECT Auction__r.Auction_Title__c, Auction__r.Image__c, Auction__r.Shipping_Cost__c, Name FROM Bid__c WHERE Id=:bidIds];
        for (Integer i = 0; i < bidsMapList.size(); i++) {
            Map<String, Object> bidsMap = bidsMapList[i];
            Map<String, Object> auctionMap = auctionList[i].getPopulatedFieldsAsMap();
            bidsMap.putAll(auctionMap);
        }
        return bidsMapList;
    }
}