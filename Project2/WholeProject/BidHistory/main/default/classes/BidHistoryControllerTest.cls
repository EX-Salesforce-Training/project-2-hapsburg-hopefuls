@isTest
public class BidHistoryControllerTest {
    @isTest
    public static void getResultsTest() {
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
        
        List<Bid__c> retrievedBids = BidHistoryController.getResults(newAuction.Id);
        System.assertEquals(5, retrievedBids.size());
    }
}