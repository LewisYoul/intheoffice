import { Controller } from "stimulus"

export default class extends Controller {
  connect() {
    // document.addEventListener("turbo:frame-render", function(event) {
    //   console.log('frame', event.target)
    //   const targetElement = event.target.firstElementChild;

    //   targetElement.classList.add('animate-cart-in')

    //   targetElement.addEventListener("animationstart", () => {
    //     targetElement.classList.remove('translate-y-96')
    //   });
    // });

    document.addEventListener("turbo:before-stream-render", function(event) {
      // Add a class to an element we are about to add to the page
      // as defined by its "data-stream-enter-class"
      if (event.target.firstElementChild instanceof HTMLTemplateElement) {
        var enterAnimationClass = event.target.templateContent.firstElementChild.dataset.streamEnterClass
        if (enterAnimationClass) {
          event.target.templateElement.content.firstElementChild.classList.add(enterAnimationClass)
        }
      }

      const turboStreamTag = event.target;
      const isReplaceStream = turboStreamTag.getAttribute('action') == 'replace'

      if (isReplaceStream) {
        const elementToReplace = document.getElementById(turboStreamTag.target);
        const streamExitClass = elementToReplace.dataset.streamExitClass

        if (streamExitClass) {
          event.preventDefault();

          elementToReplace.classList.add(streamExitClass);

          elementToReplace.addEventListener("animationend", function() {
            turboStreamTag.performAction();
          })
        }
      }
    
      // Add a class to an element we are about to remove from the page
      // as defined by its "data-stream-exit-class"
      // var elementToRemove = document.getElementById(event.target.target)
      // var streamExitClass = elementToRemove.dataset.streamExitClass
      // if (streamExitClass) {
      //   // Intercept the removal of the element
      //   event.preventDefault()
      //   elementToRemove.classList.add(streamExitClass)
      //   // Wait for its animation to end before removing the element
      //   elementToRemove.addEventListener("animationend", function() {
      //     event.target.performAction()
      //   })
      // }
    })
  }
}