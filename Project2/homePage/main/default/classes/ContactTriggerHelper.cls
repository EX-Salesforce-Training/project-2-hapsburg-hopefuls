public class ContactTriggerHelper {

    public void checkAge(List<Contact> newContacts){
        
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