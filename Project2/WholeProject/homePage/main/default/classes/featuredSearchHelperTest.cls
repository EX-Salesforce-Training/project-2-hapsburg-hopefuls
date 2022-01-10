@isTest
public with sharing class featuredSearchHelperTest {
    @isTest static void testSearch(){
        Contact testContact = new Contact();
        testContact.Birthdate = Date.newInstance(System.today().year()-20, system.today().month(), system.today().day());
        testContact.LastName = 'bob';
    	List<Auction__c> testAuction = new List<Auction__c>();
        Auction__c valid = new Auction__c();
        
        for(integer x = 7; x > 0; x--){
            Auction__c auc = new Auction__C();
            String name = 'Auction '+x;
            auc.Auction_Title__c = name;
            String elec = 'Electronics';
            auc.Product_Tags__c = elec;
            insert auc;
            
            for(integer y = x; y > 0; y--){
                Bid__c testBid = new Bid__c();
                testBid.Contact__c = testContact.Id;
                testBid.Auction__c = auc.Id;
                testBid.Price__c = 10*x;
            }
            
            testAuction.add(auc);
            if(x == 7){
                valid = auc;
            }
            
        }
        List<Auction__c> response = featuredSearchHelper.getAuctionList('Electronics');
        System.debug(response.size());
        System.assertEquals(response[0], valid);
    }
}
