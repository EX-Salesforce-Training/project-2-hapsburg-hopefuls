@isTest
public class BuyerControllerTest {

    @TestSetup
    private static void testSetup() {
        User user1 = ProfileControllerTest.setupCustomerUser();
        User user2 = setupAdditionalCustomerUser(user1);
        setupBids(user1, user2);
    }
    
    public static User setupAdditionalCustomerUser(User origUser) {
        Contact origContact = [SELECT Id, AccountId FROM Contact WHERE Id=:origUser.ContactId LIMIT 1];
        
        Contact contact = new Contact(
            FirstName = 'Jane',
            LastName = 'Smith',
            AccountId = origContact.AccountId
        );
        insert contact;
        
        User user = new User(
            Username = 'jane@example.com',
            ContactId = contact.Id,
            FirstName = 'Jane',
            LastName = 'Smith',
            Email = 'jane@example.com',
            Alias = 'jane',
            TimeZoneSidKey = 'America/New_York',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'ISO-8859-1',
            ProfileId = origUser.ProfileId,
            LanguageLocaleKey = 'en_US'
        );
        insert user;
        return user;
    }
    
    public static void setupBids(User user1, User user2) {
        List<Auction__c> auctions = new List<Auction__c>{
            new Auction__c(Auction_Title__c='Umbrella', Minimum_Bid__c=10, End_Date__c=DateTime.now().addMinutes(30))
        };
        insert auctions;
        
        Bid__c bid1 = new Bid__c(Contact__c=user1.ContactId, Price__c=20, Auction__c=auctions[0].Id);
        Bid__c bid2 = new Bid__c(Contact__c=user2.ContactId, Price__c=30, Auction__c=auctions[0].Id);
        insert bid1;
        insert bid2;
    }
    
    @isTest
    private static void getBidsTest() {
        User runAsUser = [SELECT Id FROM User WHERE Username='john@example.com'];
        // Jane's contact
        Contact contact2 = [SELECT Id FROM Contact WHERE Name='Jane Smith'];
        Auction__c auction = [SELECT Id FROM Auction__c WHERE Auction_Title__c='Umbrella'];
        System.runAs(runAsUser) {
        	Object bid = BuyerController.getBids()[0];
            Map<String, Object> bidDetails = (Map<String, Object>) bid;
            System.assertEquals(bidDetails.get('Auction__c'), auction.Id);
            // John's Bid (CurrentUser): 20
            System.assertEquals(bidDetails.get('CustomerBid'), 20);
            // Jane's Bid (Max): 30
            System.assertEquals(bidDetails.get('MaxBid'), 30);
            // Jane's ContactId (Max Bidder Id)
            System.assertEquals(bidDetails.get('MaxBid_Contact__c'), contact2.Id);
        }
    }
    
    @isTest
        // Reject bid lists of different lengths
        private static void combineBidsNegativeTest() {
            List<Bid__c> bids1 = [SELECT Id FROM Bid__c LIMIT 2];
            List<Bid__c> bids2 = [SELECT Id FROM Bid__c LIMIT 1];
            List<Map<String, Object>> combinedBids = BuyerController.combineBids(bids1, bids2);
			System.assertEquals(combinedBids, null);
        }
    
}