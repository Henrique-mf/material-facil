import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="arrow-back"
export default class extends Controller {
  connect() {
    console.log("oi")
  }
  goBack() {
    window.history.back()
    // console.log("ola")
  }
}
