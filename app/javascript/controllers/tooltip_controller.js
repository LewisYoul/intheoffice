import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['tooltip'];
  
  toggle() {
    this.tooltipTarget.classList.toggle('hidden')
  }
}