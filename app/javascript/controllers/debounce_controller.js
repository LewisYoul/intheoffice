import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['button'];
  
  handleInput() {
    if (this.timeout) { clearTimeout(this.timeout) }

    this.timeout = setTimeout(() => {
      this.buttonTarget.click();
    }, 300)
  }

  submitEnd(event) {
    let formData = event.detail.formSubmission.formData

    const searchTerm = formData.get('search')
    const existingParams = new URLSearchParams(window.location.search)

    if (searchTerm) {
      existingParams.set('search', searchTerm)
    } else {
      existingParams.delete('search')
    }

    const baseUrl = window.location.origin + window.location.pathname
    const queryString = existingParams.toString()
    const searchUrl = queryString.length > 0 ? `${baseUrl}?${queryString}` : baseUrl

    history.pushState({}, null, searchUrl);
  }
}