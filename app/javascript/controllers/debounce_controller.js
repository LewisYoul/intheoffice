import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['button'];
  
  handleInput() {
    if (this.timeout) { clearTimeout(this.timeout) }

    this.timeout = setTimeout(() => {
      this.buttonTarget.click();
    }, 300)
  }
}