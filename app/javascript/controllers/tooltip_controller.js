import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['tooltip'];

  connect() {
    console.log('notif')
    this.isShowing = false
  }
  
  toggle() {
    
    console.log('tog')
    this.tooltipTarget.classList.toggle('hidden')
  }
}