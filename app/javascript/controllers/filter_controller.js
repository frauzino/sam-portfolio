import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filter"
export default class extends Controller {

  static targets = ["filter", "item"]

  connect() {
    this.activateFilter(this.filterTargets[0])
    this.addTouchSupport
  }

  filter(event) {
    const selectedFilter = event.currentTarget
    const filter = selectedFilter.dataset.filter

    this.activateFilter(selectedFilter)

    this.itemTargets.forEach((item) => {
      if (filter === "all" || item.dataset.filter === filter) {
        item.classList.remove("hidden")
      } else {
        item.classList.add("hidden")
      }
    });
  }

  activateFilter(filter) {
    this.filterTargets.forEach((f) => f.classList.remove("active"))

    filter.classList.add("active")
  }

  addTouchSupport() {
    this.filterTargets.forEach((filter) => {
      filter.addEventListener("touchstart", (event) => {
        event.preventDefault() // Prevent default touch behavior
        this.filter(event) // Trigger the filter method
      }, { passive: true })
    })
  }
}
