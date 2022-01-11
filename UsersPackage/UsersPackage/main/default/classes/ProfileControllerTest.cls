@isTest
public class ProfileControllerTest {
	
    @testSetup
    private static void testSetup() {
        setupCustomerUser();
    }
    
    public static User setupCustomerUser() {
        Profile profile = [SELECT Id, Name FROM Profile WHERE Name='Custom: Customer' LIMIT 1];
        System.debug(profile);
        
        Account account = new Account(
        	name = 'Registrants'
        );
        insert account;
        
        Contact contact = new Contact(
            FirstName = 'John',
            LastName = 'Smith',
            AccountId = account.id
        );
        insert contact;
        
        User user = new User(
            Username = 'john@example.com',
            ContactId = contact.Id,
            FirstName = 'John',
            LastName = 'Smith',
            Email = 'test@example.com',
            Alias = 'john',
            TimeZoneSidKey = 'America/New_York',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'ISO-8859-1',
            ProfileId = profile.Id,
            LanguageLocaleKey = 'en_US'
        );
        insert user;
        return user;
    }
    
    @isTest
    private static void getProfileTest() {
        User runAsUser = [SELECT Id FROM User WHERE Username='john@example.com'];
        Contact customerContact = [SELECT Name, Id FROM Contact WHERE Name='John Smith'];
        System.runAs(runAsUser) {
        	Contact contact = ProfileController.getProfile();
            System.assertEquals(contact, customerContact);
        }
    }
    
    private static void notes() {
        /*
        SObjectType ProfileType = Schema.getGlobalDescribe().get('Profile');
        Map<String,Schema.SObjectField> pfields = ProfileType.getDescribe().fields.getMap();
        // Map<String, Schema.SObjectField> fieldMap = Schema.SObjectType.Account.fields.getMap();
        for (Schema.SObjectField field : pfields.values()) {
            System.debug(field);
        }
        SObjectType UserLicenseType = Schema.getGlobalDescribe().get('UserLicense');
        Map<String,Schema.SObjectField> ufields = UserLicenseType.getDescribe().fields.getMap();
        // Map<String, Schema.SObjectField> fieldMap = Schema.SObjectType.Account.fields.getMap();
        for (Schema.SObjectField field : ufields.values()) {
            System.debug(field);
        }
        List<Profile> profiles = [SELECT Id, Name FROM Profile];
        for (Profile profile : profiles) {
            System.debug(profile);
        }*/
        
    } 
    
}