@isTest
public class AuctionTriggerTest {
	
    @isTest
    public static void validateMinimumBidTest() {
        
        List<Auction__c> testInsertList = new List<Auction__c>();
        for(Integer i = 0; i < 10; i++) {
            Auction__c newAuction = new Auction__c();
            newAuction.Auction_Title__c = 'auction' + i;
            if(i < 5) {
                newAuction.Minimum_Bid__c = 0;
            } else {
                newAuction.Minimum_Bid__c = 5;
            }
            testInsertList.add(newAuction);
        }
        
        Integer failCounter = 0;
        for(Auction__c auction: testInsertList) {
            try {
                insert auction;
            } catch(Exception e) {
                System.debug(e);
                failCounter++;
            }
        }
        
        System.assertEquals(5, failCounter);
    }
    
    @isTest
    public static void validateImageFieldTest() {
        
		List<Auction__c> testInsertList = new List<Auction__c>();
        for(Integer i = 0; i < 10; i++) {
            Auction__c newAuction = new Auction__c();
            newAuction.Auction_Title__c = 'auction' + i;
            if(i < 5) {
                newAuction.Image__c = '<p>hello</p>';
            } else {
                newAuction.Image__c = '<img src="www.google.com/potato">';
            }
            testInsertList.add(newAuction);
        }
        
        Integer failCounter = 0;
        for(Auction__c auction: testInsertList) {
            try {
                insert auction;
            } catch(Exception e) {
                System.debug(e);
                failCounter++;
            }
        }
        System.assertEquals(5, failCounter);
    }
    
}