public with sharing class DuplicateContactTriggerHandler {
    @AuraEnabled
		public static void beforeInsertHandler(List<Contact>newRecords) {

			DuplicateContactTriggerHelper.checkContact(newRecords);
	}
	public static void beforeUpdateHandler(List<Contact>newRecords){

		DuplicateContactTriggerHelper.checkContact(newRecords);
	}
	public static void afterUndeleteHandler(List<Contact>newRecords){
		
		DuplicateContactTriggerHelper.checkContact(newRecords);
	}
}
