trigger ContactTrigger on Contact (before insert, before update) {
    
    switch on Trigger.operationType{
        when BEFORE_INSERT{
            ContactTriggerHelper.checkAge(Trigger.new);
            ContactTriggerHelper.checkContact(Trigger.new);
        }
        when BEFORE_UPDATE{
            ContactTriggerHelper.checkAge(Trigger.new);
            ContactTriggerHelper.checkContact(Trigger.new);
        }
    }
}