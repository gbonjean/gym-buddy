import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="aftereffect"
export default class extends Controller {
  connect() {

    var btnContainer = document.getElementById("navbar-container");

    var btns = btnContainer.getElementsByClassName("list-navbar");


    for (var i = 0; i < btns.length; i++) {
      btns[i].addEventListener("click", function() {
        var current = document.getElementsByClassName("active");

        if (current.length > 0) {
          current[0].className = current[0].className.replace(" active", "");
        }
        this.className += " active";
      });
    }
  }
}
