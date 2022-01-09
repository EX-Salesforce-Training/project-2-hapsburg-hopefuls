({
    handleFilter: function (component, event, helper) {
        var data = component.get("v.value");
        const message = { filterData: data };
        component.find("Filter").publish(message);
    },
    handleTag: function (component, event, helper) {
        var data = event.target.value;
        const message = { filterData: data };
        sessionStorage.setItem("SearchResult", "potato");
        component.find("Filter").publish(message);
    }
});