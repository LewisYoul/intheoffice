import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['button', 'panel']

  showPanel() {
    this.panelTarget.classList.remove('hidden')
  }

  closePanel() {
    this.panelTarget.classList.add('hidden')
  }
}