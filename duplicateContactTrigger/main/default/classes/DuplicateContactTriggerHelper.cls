public with sharing class DuplicateContactTriggerHelper {
    @AuraEnabled
		public static void checkContact(List<Contact>ContactTOCheck){

			Set<string> emailSet = new Set<string>();
								
			// Assign the values of the new records to unique sets
			for(contact c : ContactTOCheck){
					emailSet.add(c.email);
					
			}
			// Query using those unique values as clauses.
			List<Contact> conList = [SELECT lastname, email FROM Contact 
															 WHERE email IN :emailSet];
			// If we found any duplicates lets add an error to them.
			if(conList.size() > 0){
					for(Contact c: ContactTOCheck) {
							for(Contact con : conList) {
									if(con.email == c.email) {
											c.addError('Duplicate contact found. Contact ' +c.email+ ' already exists.');
									}
							}
					}
			}

		}
}
