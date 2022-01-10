@isTest
public class ProfileControllerTest {
	/*
    @testSetup
    private static void testSetup() {
        SObjectType ProfileType = Schema.getGlobalDescribe().get('User');
        Map<String,Schema.SObjectField> pfields = ProfileType.getDescribe().fields.getMap();
        // Map<String, Schema.SObjectField> fieldMap = Schema.SObjectType.Account.fields.getMap();
        for (Schema.SObjectField field : pfields.values()) {
            System.debug(field);
        }
        Profile profile = [SELECT Id FROM Profile WHERE Name='Customer Community User' LIMIT 1];
        
        Account account = new Account(
        	name = 'Registrants'
        );
        insert account;
        
        Contact contact = new Contact(
            FirstName = 'John',
            LastName = 'Smith'
        );
        insert contact;
        
        User user = new User(
            Username = 'test@example.com',
            ContactId = contact.Id,
            FirstName = 'John',
            LastName = 'Smith',
            Email = 'test@example.com',
            Alias = 'jsmit',
            TimeZoneSidKey = 'America/New_York',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'ISO-8859-1',
            ProfileId = profile.Id,
            LanguageLocaleKey = 'en_US'
        );
        insert user;
    }
    
    @isTest
    private static void getUserTest() {
        User runAsUser = [Select Id FROM User WHERE Username='test@example.com'];
        System.debug(runAsUser);
        System.runAs(runAsUser) {
        	User user = ProfileController.getUser();
            System.debug(user);
        }
    }
*/
    
    private static void discard() {
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