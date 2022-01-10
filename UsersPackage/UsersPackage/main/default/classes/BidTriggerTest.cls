@isTest
public class BidTriggerTest {
    
    @TestSetup
    private static void testSetup() {
        List<Contact> contacts = new List<Contact>{
            new Contact(FirstName='John', LastName='Smith'),
            new Contact(FirstName='Jane', LastName='Smith')
        };
        insert contacts;
        
        List<Auction__c> auctions = new List<Auction__c>{
            new Auction__c(Auction_Title__c='Umbrella', Minimum_Bid__c=10, End_Date__c=DateTime.now().addMinutes(30))
        };
        insert auctions;
        
        // Confirms that the auction end date increases
        // System.debug([SELECT Auction_Title__c, Minimum_Bid__c, End_Date__c FROM Auction__c WHERE Id=:auctions[0].Id LIMIT 1]);
        Bid__c bid1 = new Bid__c(Contact__c=contacts[0].Id, Price__c=20, Auction__c=auctions[0].Id);
        Bid__c bid2 = new Bid__c(Contact__c=contacts[1].Id, Price__c=30, Auction__c=auctions[0].Id);
        insert bid1;
        insert bid2;
        // System.debug([SELECT Auction_Title__c, Minimum_Bid__c, End_Date__c FROM Auction__c WHERE Id=:auctions[0].Id LIMIT 1]);
    }
    
    @isTest
    private static void validateBulkNegativeTest() {
        List<Bid__c> bids = new List<Bid__c>{
        	new Bid__c(),
        	new Bid__c() 
        };
        try {
            insert bids;
        } catch (System.DmlException e) {
            System.assertEquals(e.getDmlType(0), StatusCode.FIELD_CUSTOM_VALIDATION_EXCEPTION);
            System.assertEquals(e.getDmlMessage(0), 'Cannot add more than one bid at a time.');
        }
    }
    
    @isTest
    private static void validateLowerThanMaxNegativeTest() {
        List<Contact> contacts = [SELECT Id from Contact LIMIT 2];
        Auction__c auction = [SELECT Id FROM Auction__c LIMIT 1];
        Bid__c bid = new Bid__c(Contact__c=contacts[0].Id, Price__c=25, Auction__c=auction.Id);
        Bid__c maxBid = [SELECT Price__c FROM Bid__c WHERE Auction__c=:auction.Id ORDER BY Price__c DESC LIMIT 1];
        try {
        	insert bid;
        } catch (System.DmlException e) {
            System.assertEquals(e.getDmlType(0), StatusCode.FIELD_CUSTOM_VALIDATION_EXCEPTION);
            System.assertEquals(
                e.getDmlMessage(0),
                String.format(
                    'New bid amount ({0}) cannot be lower than the maximum bid amount ({1}).',
                    new List<Object>{bid.Price__c, maxBid.Price__c}
                )
            );
        }
    }
    
    @isTest
    private static void validateLowerThanMinNegativeTest() {
        // Clear all bids before running test.
        List<Bid__c> preBids = [SELECT Id FROM Bid__c];
        delete preBids;
        
        List<Contact> contacts = [SELECT Id FROM Contact LIMIT 2];
        Auction__c auction = [SELECT Id, Minimum_Bid__c FROM Auction__c LIMIT 1];
        Bid__c bid = new Bid__c(Contact__c=contacts[0].Id, Price__c=9, Auction__c=auction.Id);
        try {
        	insert bid;
        } catch (System.DmlException e) {
            System.assertEquals(e.getDmlType(0), StatusCode.FIELD_CUSTOM_VALIDATION_EXCEPTION);
            System.assertEquals(
                e.getDmlMessage(0),
                String.format(
                    'New bid amount ({0}) cannot be lower than the starting bid amount ({1}).',
                    new List<Object>{bid.Price__c, auction.Minimum_Bid__c}
                )
            );
        }
    }
}