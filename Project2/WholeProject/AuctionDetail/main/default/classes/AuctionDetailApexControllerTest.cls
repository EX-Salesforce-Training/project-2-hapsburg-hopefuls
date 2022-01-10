@isTest
public class AuctionDetailApexControllerTest {
	
    @isTest
    public static void getAuctionTest() {
        Auction__c newAuction = new Auction__c();
        
        newAuction.Auction_Title__c = 'New Auction';
        newAuction.Condition__c = 'Mint';
        newAuction.Description__c= 'This is New Auction';
        newAuction.Minimum_Bid__c = 5;
    	
        insert newAuction;
        
        Auction__c retrievedAuction = AuctionDetailApexController.getAuction(newAuction.Id);
        
        System.assertEquals('New Auction', retrievedAuction.Auction_Title__c);
    }
    
    @isTest
    public static void getUserTest() {
        Contact newContact = new Contact();
        
        newContact.Email = UserInfo.getUserEmail();
        newContact.FirstName = 'this is for sure a test name';
        newContact.LastName = 'Smith';
        newContact.Birthdate = Date.newInstance(1985, 12, 1);
        
        insert newContact;
        Contact retrievedContact = AuctionDetailApexController.getUser();
        System.assertEquals('this is for sure a test name', retrievedContact.FirstName);
    }
    
    @isTest
    public static void getBidsTest() {
        Auction__c newAuction = new Auction__c();
        Contact newContact = new Contact();
        List<Bid__c> bidInsertList = new List<Bid__c>();
        
        newAuction.Auction_Title__c = 'Test Auction';
        newAuction.Minimum_Bid__c = 5;
        newAuction.Condition__c = 'Mint';
        newContact.LastName = 'Smith';
        newContact.Birthdate = Date.newInstance(1985, 12, 1);
        insert newAuction;
        insert newContact;
        
        for(Integer i = 0; i < 5; i++) {
            Bid__c newBid = new Bid__c();
            newBid.Contact__c = newContact.Id;
            newBid.Auction__c = newAuction.Id;
            newBid.Price__c = (6 + i);
            insert newBid;
        }
        
        List<Bid__c> retrievedBids = AuctionDetailApexController.getBids(newAuction.Id);
        System.assertEquals(5, retrievedBids.size());
    }
}