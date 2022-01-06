public without sharing class ProfileController {
    @AuraEnabled(cacheable=true)
    public static User getUser() {
        User user = [SELECT name, contactId FROM User WHERE Id=:UserInfo.getUserId()];
        return user;
    }
    
	@AuraEnabled(cacheable=true)
    public static Contact getProfile() {
        User user = [SELECT contactId FROM User WHERE Id=:UserInfo.getUserId()];
        Contact contact = [SELECT name, email FROM Contact WHERE Id=:user.ContactId];
        //Contact contact = [SELECT name FROM Contact];
        return contact;
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Bid__c> getBids() {
        User user = [SELECT contactId FROM User WHERE Id=:UserInfo.getUserId()];
        Contact contact = [SELECT name FROM Contact WHERE Id=:user.ContactId];
        Bid__c[] bids = [SELECT Auction__c, Auction__r.Auction_Title__c, Auction__r.Image__c, Price__c, Contact__c FROM Bid__c WHERE Contact__c=:contact.Id];
        //Bid__c[] bids = [SELECT Auction__c, Auction__r.Auction_Title__c, Auction__r.Image__c, Price__c, Contact__c FROM Bid__c];
        return bids;
    }
}