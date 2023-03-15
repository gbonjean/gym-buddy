import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="aks-notifications"
export default class extends Controller {
  static values = { currentUserId: Number, asks: Array }
  static targets = ["eventPill"]

  connect() {
    this.#initCounters()
    this.channel = createConsumer().subscriptions.create(
      { channel: "NotificationsChannel", id: this.currentUserIdValue },
      { received: data => {
        if (data.ask) {
        this.askCounts[data.ask] = (this.askCounts[data.ask] || 0) + 1;
        this.#print()
      }}}
    )
  }

  disconnect() {
    this.channel.unsubscribe()
  }

  #initCounters() {
    this.askCounts = {};
    for (let i = 0; i < this.asksValue.length; i++) {
      const message = this.asksValue[i]
      this.askCounts[message] = (this.askCounts[message] || 0) + 1
    }
    this.#print()
  }

  #print() {
    this.eventPillTargets.forEach(element => {
      element.textContent = this.askCounts[element.dataset.eventIndex]
    })
  }
}
