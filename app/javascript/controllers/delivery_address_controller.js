import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="delivery-address"
export default class extends Controller {
  static targets = ['button', 'input', 'form', 'address'];

  connect() {
  }

  open(event) {


    this.buttonTarget.classList.add('d-none');
    this.formTarget.classList.remove('d-none');
  }

  submit(event) {
    event.preventDefault();

    fetch(`/geocode?zip_code=${this.inputTarget.value}`)
        .then(response => response.json())
        .then(data => {
          if (data.error) {
            this.addressTarget.innerText = 'Error: ' + data.error;
          } else {
            this.addressTarget.innerText =  'Delivering to ' + data.address;
            this.formTarget.classList.add('d-none');
          }
        })
        .catch(error => {
          this.addressTarget.innerText = 'An error occurred: ' + error.message;
        });
  }

}
