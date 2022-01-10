trigger ContactTrigger on Contact (before insert, before update) {
	ContactTriggerHelper helper = new ContactTriggerHelper();
    
    switch on Trigger.operationType{
        when BEFORE_INSERT{
            helper.checkAge(Trigger.new);
        }
        when BEFORE_UPDATE{
            helper.checkAge(Trigger.new);
        }
    }
}