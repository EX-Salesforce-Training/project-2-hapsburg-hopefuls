public class ProfileController {
    @AuraEnabled(cacheable=true)
    public static User getUser() {
        User user = [SELECT name, contactId FROM User WHERE Id=:UserInfo.getUserId()];
        return user;
    }
    
	@AuraEnabled(cacheable=true)
    public static Contact getProfile() {
        List<String> fields = new List<String>{'Name'};
        Contact contact = getProfileWithFields(fields);
        return contact;
    }
    
    @AuraEnabled(cacheable=true)
    public static Contact getProfileWithFields(List<String> fields) {
        // Debug SOQL statement as Non-customer User
        // String soql = 'SELECT ' + String.escapeSingleQuotes(String.join(fields, ', ')) + ' FROM Contact LIMIT 1';
        Id userContact = getUser().ContactId;
        String soql = 'SELECT ' + String.escapeSingleQuotes(String.join(fields, ', ')) + ' FROM Contact WHERE Id=:userContact';
        Contact contact = Database.query(soql);
        return contact;
    }
}