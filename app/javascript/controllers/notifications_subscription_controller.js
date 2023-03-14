import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="notifications-subscription"
export default class extends Controller {
  static values = { currentUserId: Number, answers: Array, asks: Array, messages: Array }
  static targets = ["navMessagePill", "chatMessagePill", "navEventPill", "eventPill"]

  connect() {
    // console.log('ggg');
    this.#initCounters()
    this.channel = createConsumer().subscriptions.create(
      { channel: "NotificationsChannel", id: this.currentUserIdValue },
      { received: data => this.#route(data) }
    )
  }

  #initCounters() {
    this.messagesNavCount = this.messagesValue.length
    this.asksNavCount = this.asksValue.length
    this.chatCounts = {};
    for (let i = 0; i < this.messagesValue.length; i++) {
      const message = this.messagesValue[i]
      this.chatCounts[message] = (this.chatCounts[message] || 0) + 1
    }
    this.eventCounts = {};
    for (let i = 0; i < this.asksValue.length; i++) {
      const ask = this.asksValue[i]
      this.eventCounts[ask] = (this.eventCounts[ask] || 0) + 1
    }
    this.#print()
  }

  #route(data) {
    if (data.message) {
      this.#update_messages(data)
    } else if (data.ask) {
      this.#update_asks(data)
    }
  }

  #update_messages(data) {
    this.messagesNavCount += 1
    this.chatCounts[data.message] = (this.chatCounts[data.message] || 0) + 1;
    this.#print()
  }

  #update_asks(data) {
    this.asksNavCount += 1
    this.eventCounts[data.asks] = (this.eventCounts[data.asks] || 0) + 1;
    this.#print()
  }

  #print() {
    this.navMessagePillTarget.textContent = (this.messagesNavCount > 0) ? this.messagesNavCount : ''
    this.navEventPillTarget.textContent = (this.asksNavCount > 0) ? this.asksNavCount : ''
    this.chatMessagePillTargets.forEach(element => {
      element.textContent = this.chatCounts[element.dataset.chatIndex]
    })
    this.eventPillTargets.forEach(element => {
      element.textContent = this.eventCounts[element.dataset.eventIndex]
    })

  }

}
