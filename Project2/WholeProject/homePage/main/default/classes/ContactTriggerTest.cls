@isTest
public class ContactTriggerTest {
	
    @isTest
    public static void checkAgeTest() {
        List<Contact> insertList = new List<Contact>();
        
        for(Integer i = 0; i < 15; i++) {
            Contact newContact = new Contact();
            Date today = Date.today();
            newContact.LastName = '' + i;
            newContact.email = 'test' + i + '@gmail.com';
            if(i < 5) {
                Date newDate = today.addYears(-18);
                newContact.Birthdate = newDate;
            } else if(i < 10) {
                Date newDate = today.addDays(1);
                newContact.Birthdate = newDate;
            } else {
                Date newDate = today.addYears(-10);
                newContact.Birthdate = newDate;
            }
            insertList.add(newContact);
        }
        
        Integer failCount = 0;
        for(Contact c: insertList) {
            try {
                insert c;
            } catch(Exception e) {
                System.debug(e);
                failCount++;    
            }
        }
        System.assertEquals(10, failCount);
    }
    
    @isTest
    public static void checkContactTest() {
        List<Contact> insertList = new List<Contact>();
        for(Integer i = 0; i < 10; i++) {
            Contact newContact = new Contact();
            newContact.LastName = '' + i;
            newContact.Birthdate = Date.newInstance(1960, 2, 17);
            if(i < 5) {
                newContact.Email = 'tim@gmail.com';
            } else {
                newContact.Email = 'john' + i + '@gmail.com';
            }
            insertList.add(newContact);
        }
        
        Integer failCount = 0;
        for(Contact c: insertList) {
            try {
                insert c;
            } catch (Exception e) {
                System.debug(e);
                failCount++;
            }
        }
        
        System.assertEquals(4, failCount);
    }
}