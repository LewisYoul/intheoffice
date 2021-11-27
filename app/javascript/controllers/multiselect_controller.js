import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['allButton', 'clearButton', 'openIcon', 'closedIcon', 'option', 'options', 'check', 'spacer', 'dropdown', 'selected', 'select']
  static classes = ['selected']
  static values = { selected: Boolean }

  connect() {
    this.setCountBasedElements()
  }

  hide(event) {
    if (!this.element.contains(event.target)) { this.hideMultiSelect() };
  }

  hideMultiSelect() {
    this.openIconTarget.classList.add('hidden')
    this.closedIconTarget.classList.remove('hidden')
    this.optionsTarget.classList.add('hidden')
  }

  toggle(event) {
    this.openIconTarget.classList.toggle('hidden')
    this.closedIconTarget.classList.toggle('hidden')
    this.optionsTarget.classList.toggle('hidden')
  }

  toggleSelection(event) {
    event.stopPropagation();

    const optionElement = event.currentTarget
    const index = this.optionTargets.indexOf(optionElement)
    const option = this.optionTargets[index]
    const check = this.checkTargets[index]
    const spacer = this.spacerTargets[index]

    option.classList.toggle(this.selectedClass)
    check.classList.toggle('hidden')
    spacer.classList.toggle('hidden')

    const isSelected = !JSON.parse(option.dataset.selected)
    option.dataset.selected = isSelected

    const selectOptions = this.selectOptions()

    selectOptions[index].selected = isSelected

    this.setCountBasedElements()

    const changeEvent = new Event('change')
    this.selectTarget.form.dispatchEvent(changeEvent)
  }

  deselectAll(event) {
    event.preventDefault()
    event.stopPropagation()

    const selectOptions = this.selectOptions()

    for (let i = 0; i < selectOptions.length; i++) {
      const option = this.optionTargets[i]
      const check = this.checkTargets[i]
      const spacer = this.spacerTargets[i]
      
      option.dataset.selected = false
      selectOptions[i].selected = false

      option.classList.remove(this.selectedClass)
      check.classList.add('hidden')
      spacer.classList.remove('hidden')
      
    }

    this.setCountBasedElements()
  }

  selectAll(event) {
    event.preventDefault()
    event.stopPropagation()

    const selectOptions = this.selectOptions()

    for (let i = 0; i < selectOptions.length; i++) {
      const option = this.optionTargets[i]
      const check = this.checkTargets[i]
      const spacer = this.spacerTargets[i]
      
      option.dataset.selected = true
      selectOptions[i].selected = true

      option.classList.add(this.selectedClass)
      check.classList.remove('hidden')
      spacer.classList.add('hidden')
    }

    this.setCountBasedElements()
  }

  selectOptions() {
    return Array.from(this.selectTarget.options)
  }

  setCountBasedElements() {
    const selectedCount = this.optionTargets.filter(option => {
      return JSON.parse(option.dataset.selected)
    }).length

    if (selectedCount == this.optionTargets.length) {
      this.allButtonTarget.classList.add('text-gray-500')
      this.clearButtonTarget.classList.remove('text-gray-500')
    } else if (selectedCount == 0) {
      this.allButtonTarget.classList.remove('text-gray-500')
      this.clearButtonTarget.classList.add('text-gray-500') 
    } else {
      this.allButtonTarget.classList.remove('text-gray-500')
      this.clearButtonTarget.classList.remove('text-gray-500')    
    }

    this.dropdownTarget.innerHTML = `Participants ${selectedCount}`
  }
}