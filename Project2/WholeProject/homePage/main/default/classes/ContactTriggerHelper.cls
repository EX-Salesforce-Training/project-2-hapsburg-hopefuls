public class ContactTriggerHelper {

    public static void checkAge(List<Contact> newContacts){
        
        // instantiate all needed variables to calculate age
        Date presentDate = System.today();
        Integer presentDay = presentDate.Day();
        Integer presentMonth = presentDate.Month();
        Integer presentYear = presentDate.Year();
        
        Date birth_Date;
        Integer birthDay;
        Integer birthMonth;
        Integer birthYear;
        
        Integer finalYear;
        
        // Perform logic for each new contact being created.
        for(Contact newContact : newContacts){
            if(newContact.Birthdate != null) {
                birth_Date = newContact.Birthdate;
                birthDay = birth_Date.Day();
                birthMonth = birth_Date.Month();
                birthYear = birth_Date.Year();
                
                // if the birthday is AFTER present day, throw an error
                if(birth_Date > presentDate){
                    newContact.Birthdate.addError('Invalid Age, Birthdate can not be a future date.');
                    continue;
                }
                
                // If the birth month has not yet passed, ignore current year.
                if(birthMonth > presentMonth){
                    presentYear = presentYear - 1;
                }
                // If it is the birth month, but not yet the birth day, ignore current year.
                else if(birthMonth <= presentMonth && birthDay > presentDay){
                    presentYear = presentYear - 1;
                }
                
                finalYear = presentYear - birthYear;
                
                if(finalYear < 18){
                    newContact.Birthdate.addError('Invalid Age, users must be at least 18 years old.');
                }
                }
        }
    }
    
    
    	
    public static void checkContact(List<Contact> ContactTOCheck){

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
                    if(c.Email != null && con.email == c.email) {
                        c.addError('Duplicate contact found. Contact ' +c.email+ ' already exists.');
                    }
                }
            }
        }
	}
}