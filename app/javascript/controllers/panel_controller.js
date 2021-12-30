import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['button', 'panel'];
  static values = {
    open: Boolean,
    id: String
  };

  hide(event) {
    if (!this.panelTarget.contains(event.target)) {
      this.closePanel();
    }
  }

  closePanel() {
    this.panelTarget.classList.remove('animate-cart-in')
    this.panelTarget.classList.add('animate-cart-out')
    
    const animationEndEvent = () => {
      this.panelTarget.innerHTML = '';
      this.panelTarget.classList.remove('animate-cart-out')
      console.log('pt', this.panelTarget)
      this.panelTarget.removeEventListener("animationend", animationEndEvent)
    }

    this.panelTarget.addEventListener("animationend", animationEndEvent)

  }
}