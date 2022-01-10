import { LightningElement, track } from "lwc";
import Id from "@salesforce/user/Id";

export default class NavBar extends LightningElement {
    @track loggedIn = true;

    renderedCallback() {
        if (Id == null) {
            this.loggedIn = false;
        } else {
            this.loggedIn = true;
        }
    }
    handleSearch(event) {
        let searchResult = this.template.querySelector("input").value;
        sessionStorage.setItem("SearchResult", searchResult);
        window.location.href = "/s/searchresultspage";
    }
}