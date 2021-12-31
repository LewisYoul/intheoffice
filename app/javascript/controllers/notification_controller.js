import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['container', 'notification'];

  connect() {
    this.notificationTarget.classList.add('animate-notification-in')
    setTimeout(() => this.closeNotification(this.element), 5000);
  }

  // For some reason this.element is undefined when closeNotification is called from connect
  closeNotification(element) {
    if (this.hasContainerTarget) {
      this.containerTarget.remove();
    } else {
      element.remove();
    }
  }
}