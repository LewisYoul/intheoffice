import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['dropdown'];

  connect() {
    this.isShowing = false
  }

  toggle(event) {
    event.stopPropagation()

    this.isShowing ? this.hideDropdown() : this.showDropdown();
  }

  hide(event) {
    if (!this.element.contains(event.target)) { this.hideDropdown() };
  }

  showDropdown() {
    this.dropdownTarget.classList.remove('hidden')
    this.isShowing = true
  }

  hideDropdown() {
    this.dropdownTarget.classList.add('hidden')
    this.isShowing = false
  }
}