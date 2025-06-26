import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["menu"];

  connect() {
    this.element.addEventListener("touchstart", this.handleTouch.bind(this), { passive: true });
  }

  toggleMenu() {
    this.menuTarget.classList.toggle("open");
  }

  handleTouch(event) {
    // Ensure touch events trigger the toggleMenu action
    if (event.target.closest(".hamburger-menu")) {
      this.toggleMenu();
    }
  }
}
