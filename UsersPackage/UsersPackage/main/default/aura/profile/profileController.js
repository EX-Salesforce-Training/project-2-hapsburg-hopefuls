({
    init : function(component, event, helper) {
        //console.log('init');
		component.set('v.updatedCount', 0);
        component.set('v.selectedItem', 'summary');
        component.set('v.currentContent', 'summary');
        
        /*
        var loadContact = component.get("c.getProfile");
        loadContact.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var profile = response.getReturnValue();
                component.set("v.currentProfile", profile);
                // console.log(response.getReturnValue());
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
                // console.log('bids');
                // console.log(response.getReturnValue());
            } else if (state === "ERROR") {
                for (const e of response.getError()) {
                    console.error(e.message);
                }
            }
        });
        $A.enqueueAction(loadBids);
        */
    },
    
    handleSelect: function(component, event, helper) {
        // console.log(component.get('v.selectedItem'));
        // console.log(component.get('v.currentContent'));
        var selected = event.getParam('name');

        if (selected === 'reports_updated') {
            component.set('v.updatedCount', 0);
        }
        component.set('v.currentContent', selected);
        
        var payload = {
            vTab: selected
        }
        component.find("selectedVTab").publish(payload);
    }
})