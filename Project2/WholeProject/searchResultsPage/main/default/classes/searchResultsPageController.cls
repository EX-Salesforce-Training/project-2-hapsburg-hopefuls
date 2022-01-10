public with sharing class searchResultsPageController {

    @AuraEnabled (Cacheable = true)
    public static List<Auction__c> getSearchResults(String searchTerm){
        String newSearchText = '%' + searchTerm + '%';
        return [SELECT Name, Auction_Title__c, Condition__c, Description__c, Image__c, Minimum_Bid__c, Shipping_Cost__c, Product_Tags__c
                FROM Auction__c WHERE Auction_Title__c LIKE :newSearchText];
    }
}