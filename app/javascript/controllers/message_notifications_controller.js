import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="message-notifications"
export default class extends Controller {
  static values = { currentUserId: Number, messages: Array }
  static targets = ["chatMessagePill"]

  connect() {
    this.#initCounters()
    this.channel = createConsumer().subscriptions.create(
      { channel: "NotificationsChannel", id: this.currentUserIdValue },
      { received: data => {
        if (data.message) {
        this.chatCounts[data.message] = (this.chatCounts[data.message] || 0) + 1;
        this.#print()
      }}}
    )
  }

  disconnect() {
    this.channel.unsubscribe()
  }

  #initCounters() {
    this.chatCounts = {};
    for (let i = 0; i < this.messagesValue.length; i++) {
      const message = this.messagesValue[i]
      this.chatCounts[message] = (this.chatCounts[message] || 0) + 1
    }
    this.#print()
  }

  #print() {
    this.chatMessagePillTargets.forEach(element => {
      element.textContent = this.chatCounts[element.dataset.chatIndex]
    })
  }
}
