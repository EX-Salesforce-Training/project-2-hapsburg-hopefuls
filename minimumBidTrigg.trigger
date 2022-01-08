trigger minimumBidTrigg on Auction__c (before insert) {

     //We create a  list of bid to check of minimum value.

      List<Bid__c> BidList = new List<Bid__c> ();
       
    for (Auction__c auct : Trigger.new){
        if(auct.Minimum_Bid__c <= 0){

           //if the condition is met, we are going to generate a warring message.
           
                Trigger.new[0].Name.addError('Sorry! You have to enter positive value!');
         }
    }

}