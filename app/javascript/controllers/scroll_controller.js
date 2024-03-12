import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["messages"]

  connect() {
    this.observer = new MutationObserver(() => this.scrollToBottom())
    this.observer.observe(this.messagesTarget, { childList: true })
  }

  disconnect() {
    this.observer.disconnect()
  }

  scrollToBottom() {
    this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight
  }

  update() {
    setTimeout(() => this.scrollToBottom(), 100)
  }
}