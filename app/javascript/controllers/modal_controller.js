import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    document.body.style.overflow = "hidden"
    this.onKeydown = (e) => { if (e.key === "Escape") this.close() }
    document.addEventListener("keydown", this.onKeydown)
  }

  disconnect() {
    document.body.style.overflow = ""
    document.removeEventListener("keydown", this.onKeydown)
  }

  close() {
    this.element.classList.add("is-closing")
    this.element.querySelector(".app-modal")?.classList.add("is-closing")
    this.element.addEventListener("animationend", () => {
      this.element.closest("turbo-frame").innerHTML = ""
    }, { once: true })
  }

  backdropClick(event) {
    if (event.target === this.element) this.close()
  }
}
