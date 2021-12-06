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
    this.containerTarget.innerHTML = '';
  }
}