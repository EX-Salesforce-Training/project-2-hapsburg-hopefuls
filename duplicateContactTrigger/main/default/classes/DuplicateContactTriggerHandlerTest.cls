@isTest
public with sharing class DuplicateContactTriggerHandlerTest {
	@isTest
	public static void beforeInsertHandlerTest1(){
		//Set<String>testEmail= new Set<String>();
		//	testEmail.add('test1@duptest.com');
    //  testEmail.add('test2@duptest.com');
    //  testEmail.add('test3@duptest.com');
    //  testEmail.add('test4@duptest.com');
    //  testEmail.add('test5@duptest.com');
			
		List<Contact> testContacts= new List<Contact>();
		testContacts.add(new Contact(LastName='Test1', Email ='test1@duptest.com'));
		testContacts.add(new Contact(LastName='Test2', Email = 'test2@duptest.com'));
		testContacts.add(new Contact(LastName='Test3', Email = 'test3@duptest.com'));
		testContacts.add(new Contact(LastName='Test4', Email = 'test4@duptest.com'));
		testContacts.add(new Contact(LastName='Test5', Email = 'test5@duptest.com'));

		insert testContacts;

		List<Contact>allContacts =[SELECT Id, LastName, Email FROM Contact];
		System.assertEquals(5, allContacts.size());



	}
	@isTest
	public static void beforeInsertHandlerTest2(){
		List<Contact> testContacts= new List<Contact>();
		testContacts.add(new Contact(LastName='Test1', Email ='test1@duptest.com'));
		testContacts.add(new Contact(LastName='Test2', Email = 'test2@duptest.com'));
		testContacts.add(new Contact(LastName='Test3', Email = 'test1@duptest.com'));
		testContacts.add(new Contact(LastName='Test4', Email = 'test4@duptest.com'));
		testContacts.add(new Contact(LastName='Test5', Email = 'test4@duptest.com'));

		insert testContacts;

		List<Contact>allContacts =[SELECT Id, LastName, Email FROM Contact];
		System.assertEquals(3, allContacts.size());



	}
	//@isTest
	//public static void beforeUpdateHandlerTest(){
	//	List<Contact> testContacts= new List<Contact>();
	//	testContacts.add(new Contact(LastName='Test1', Email ='test1@duptest.com'));
	//	testContacts.add(new Contact(LastName='Test2', Email = 'test1@duptest.com'));
	//	testContacts.add(new Contact(LastName='Test3', Email = 'test1@duptest.com'));
	//	testContacts.add(new Contact(LastName='Test4', Email = 'test4@duptest.com'));
	//	testContacts.add(new Contact(LastName='Test5', Email = 'test4@duptest.com'));

	//	insert testContacts;
	//	List<Contact>allContacts =[SELECT Id, LastName, Email FROM Contact];
	//	System.assertEquals(2, allContacts.size());
	//}

    
}

