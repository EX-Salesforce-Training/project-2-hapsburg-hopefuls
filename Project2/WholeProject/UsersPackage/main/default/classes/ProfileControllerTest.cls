@isTest
public class ProfileControllerTest {

    // @testSetup
    // private static void testSetup() {
    //     setupCustomerUser();
    // }
    
    // public static User setupCustomerUser() {
    //     User adminUser = [Select Id, UserRoleId From User Where Profile.Name='System Administrator' Limit 1];
    //     User user;
    //     System.runAs(adminUser) {
    //     Profile profile = [SELECT Id, UserLicense.Name FROM Profile WHERE Name='Customer Community Plus User' LIMIT 1];
        
    //     Account account = new Account(
    //     	name = 'Registrants'
    //     );
    //     insert account;
        
    //     Contact contact = new Contact(
    //         FirstName = 'John',
    //         LastName = 'Smith',
    //         AccountId = account.id
    //     );
    //     insert contact;
        
    //     user = new User(
    //         Username = 'john@example.com',
    //         ContactId = contact.Id,
    //         FirstName = 'John',
    //         LastName = 'Smith',
    //         Email = 'test@example.com',
    //         Alias = 'john',
    //         TimeZoneSidKey = 'America/New_York',
    //         LocaleSidKey = 'en_US',
    //         EmailEncodingKey = 'ISO-8859-1',
    //         ProfileId = profile.Id,
    //         LanguageLocaleKey = 'en_US'
    //     );
    //     insert user;
    //     }
    //     return user;
    // }
    
    // @isTest
    // public static void getProfileTest() {
    //     User runAsUser = [SELECT Id FROM User WHERE Username='john@example.com'];
    //     Contact customerContact = [SELECT Name, Id FROM Contact WHERE Name='John Smith'];
    //     System.runAs(runAsUser) {
    //     	Contact contact = ProfileController.getProfile();
    //         System.assertEquals(contact, customerContact);
    //     }
    // }
}