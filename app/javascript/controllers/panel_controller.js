import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['button', 'panel', 'wrapper'];
  static values = {
    open: Boolean
  };

  hide(event) {
    if (this.openValue && !this.panelTarget.contains(event.target)) {
      this.closePanel();
    }
  }

  showPanel(event) {
    event.stopPropagation();

    this.wrapperTarget.classList.remove('hidden')
    this.openValue = true;
    
    Array.from(document.querySelectorAll('[autofocus]')).forEach((el) => {
      el.focus();
    })
  }

  closePanel() {
    this.wrapperTarget.classList.add('hidden')
  }
}