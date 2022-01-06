({
    init : function(component, event, helper) {
        //console.log('init');
		component.set('v.updatedCount', 12);
        component.set('v.selectedItem', 'reports_recent');
        component.set('v.currentContent', 'reports_recent');
        
        var loadContact = component.get("c.getProfile");
        loadContact.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var profile = response.getReturnValue();
                component.set("v.currentProfile", profile);
                console.log(response.getReturnValue());
            } else if (state === "ERROR") {
                for (const e of response.getError()) {
                    console.error(e.message);
                }
            }
        });
        
        $A.enqueueAction(loadContact);
        
        var loadBids = component.get("c.getBids");
        loadBids.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var bids = response.getReturnValue();
                component.set("v.bids", bids);
                console.log('bids');
                console.log(response.getReturnValue());
            } else if (state === "ERROR") {
                for (const e of response.getError()) {
                    console.error(e.message);
                }
            }
        });
        $A.enqueueAction(loadBids);
        
    },
    
    handleSelect: function(component, event, helper) {
        var selected = event.getParam('name');

        if (selected === 'reports_updated') {
            component.set('v.updatedCount', 0);
        }
        component.set('v.currentContent', selected);
    }
})