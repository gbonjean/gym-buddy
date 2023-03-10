import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";

export default class extends Controller {
  connect() {
    console.log("coucou")
    new flatpickr(this.element, {
      enableTime: true,
      minTime: "00:30",
      dateFormat: "Y-m-d",
      // more options available on the documentation!
    });
  }
}
