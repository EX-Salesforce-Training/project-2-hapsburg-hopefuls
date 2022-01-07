import { LightningElement } from "lwc";

export default class NavBar extends LightningElement {
    loggedin = true;

    handleSearch(event) {
        let searchResult = this.template.querySelector("input").value;
        sessionStorage.setItem("SearchResult", searchResult);
        window.location.href = "/s/search-result";
    }
}
