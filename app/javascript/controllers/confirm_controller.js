import { Controller } from "stimulus"

export default class extends Controller {
  static values = {
    message: String,
    url: String
  }

  static targets = ['alert']
  
  connect() {
    console.log('conn')
  }

  showConfirm(event) {
    event.preventDefault();

    this.alertTarget.classList.remove('hidden')
  }

  cancel() {
    console.log('can')
    this.alertTarget.classList.add('hidden')
  }
}