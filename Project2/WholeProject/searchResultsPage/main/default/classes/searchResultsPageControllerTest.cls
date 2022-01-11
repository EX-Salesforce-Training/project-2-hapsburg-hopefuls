@isTest
public class searchResultsPageControllerTest {

    @isTest
    public static void getSearchResultsTest(){

        for(Integer i = 0; i < 5; i++) {
            if(i < 3) {
                Auction__c newAuction = new Auction__c();
                newAuction.Auction_Title__c = 'Pokemon' + i;
                insert newAuction;
            } else {
                Auction__c newAuction = new Auction__c();
                newAuction.Auction_Title__c = 'YuGiOh' + i;
                insert newAuction;
            }
        }

        List<Auction__c> pokemonAuctions = searchResultsPageController.getSearchResults('Pokemon');
        List<Auction__c> yugiohAuctions = searchResultsPageController.getSearchResults('YuGiOh');

        System.assertEquals(3, pokemonAuctions.size());
        System.assertEquals(2, yugiohAuctions.size());
    }
}