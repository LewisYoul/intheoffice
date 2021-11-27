import { Controller } from "stimulus"
import * as Turbo from "@hotwired/turbo"

export default class extends Controller {
  static values = { url: String }

  connect() {
    this.element.classList.add('cursor-pointer')
  }

  navigate() {
    Turbo.visit(this.urlValue)
  }
}