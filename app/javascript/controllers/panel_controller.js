import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['button', 'panel']

  showPanel() {
    this.panelTarget.classList.remove('hidden')
    Array.from(document.querySelectorAll('[autofocus]')).forEach((el) => {
      el.focus();
    })
  }

  closePanel() {
    this.panelTarget.classList.add('hidden')
  }
}