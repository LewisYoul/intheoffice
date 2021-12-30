import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['button', 'panel', 'container'];
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
      this.containerTarget.innerHTML = '';
      this.containerTarget.removeEventListener("animationend", animationEndEvent)
    }

    this.containerTarget.addEventListener("animationend", animationEndEvent)

  }
}