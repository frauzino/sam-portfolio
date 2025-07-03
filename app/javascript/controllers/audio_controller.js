import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["audio", "button", "progress"]

  connect() {
    this.audio.addEventListener("timeupdate", this.updateProgress.bind(this))
    this.audio.addEventListener("ended", this.updateButton.bind(this))
    this.updateButton()
  }

  togglePlayback() {
    if (this.audio.paused) {
      this.audio.play()
    } else {
      this.audio.pause()
    }
    this.updateButton()
  }

  updateButton() {
    this.buttonTarget.textContent = this.audio.paused ? "▶" : "❚❚"
  }

  updateProgress() {
    const percent = (this.audio.currentTime / this.audio.duration) * 100
    this.progressTarget.value = percent || 0
  }

  seek(event) {
    const percent = event.target.value
    this.audio.currentTime = (percent / 100) * this.audio.duration
  }

  get audio() {
    return this.audioTarget
  }
}
