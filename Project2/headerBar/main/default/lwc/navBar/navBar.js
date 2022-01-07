import { LightningElement } from "lwc";

export default class NavBar extends LightningElement {
    loggedin = true;

    handleSearch(event) {
        window.location.href = "/search-result";
    }
}
