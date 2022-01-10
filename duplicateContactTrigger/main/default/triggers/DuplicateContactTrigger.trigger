trigger DuplicateContactTrigger on Contact (before insert,before update, after undelete) {
	Switch on Trigger.OperationType {
		when BEFORE_INSERT {
			DuplicateContactTriggerHandler.beforeInsertHandler(Trigger.new);
		} 
		when BEFORE_UPDATE {
			DuplicateContactTriggerHandler.beforeUpdateHandler(Trigger.new);
				
		}
			when AFTER_UNDELETE {
				DuplicateContactTriggerHandler.afterUndeleteHandler(Trigger.new);
				
		} 
		
	}

}