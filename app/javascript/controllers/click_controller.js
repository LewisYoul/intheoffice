import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['element'];
  
  click() {
    this.elementTarget.click();
  }
}