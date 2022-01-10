public with sharing class AuctionDetailApexController {
    @AuraEnabled
    public static Auction__c getAuction(String recId){
        return [SELECT Auction_Title__c, Condition__c, Description__c, Image__c, Minimum_Bid__c, Product_Tags__c, Shipping_Cost__c
                FROM Auction__c
                WHERE Id =: recId];
    }

    @AuraEnabled
    public static Contact getUser(){
        return [SELECT FirstName, LastName, Email FROM Contact WHERE Email =: UserInfo.getUserEmail() LIMIT 1];
    }

    @AuraEnabled
    public static List<Bid__c> getBids(String recId){
        return [SELECT Price__c FROM Bid__c WHERE Auction__c =: recId];
    }
}