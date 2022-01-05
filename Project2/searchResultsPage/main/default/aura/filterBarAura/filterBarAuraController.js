({
    handleFilter : function(component, event, helper) {
        var data = component.get("v.value");
        const message = { filterData: data };
        component.find("Filter").publish(message);
    }
})
