import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="navbar-notifications"
export default class extends Controller {
  static values = { currentUserId: Number, asks: Array, messages: Array }
  static targets = ["navEventPill", "navMessagePill"]

  connect() {
    this.#initCounters()
    this.channel = createConsumer().subscriptions.create(
      { channel: "NotificationsChannel", id: this.currentUserIdValue },
      { received: data => this.#route(data) }
    )
  }

  disconnect() {
    this.channel.unsubscribe()
  }

  #initCounters() {
    this.messagesNavCount = this.messagesValue.length
    this.asksNavCount = this.asksValue.length
    this.#print()
  }

  #route(data) {
    if (data.message) {
      if (window.location.pathname != `/chatrooms/${data.message}`) {
        this.messagesNavCount += 1
        this.#print()
      } else {
        this.#cleanMessagesNotifications()
      }
    } else if (data.ask) {
      this.asksNavCount += 1
      this.#print()
    }

  }

  #print() {
    if (this.messagesNavCount == 0) {
      this.navMessagePillTarget.classList.add("d-none");
    } else {
      this.navMessagePillTarget.classList.remove("d-none");
      this.navMessagePillTarget.textContent = this.messagesNavCount;
    }
    if (this.asksNavCount == 0) {
      this.navEventPillTarget.classList.add("d-none");
    } else {
      this.navEventPillTarget.classList.remove("d-none");
      this.navEventPillTarget.textContent = this.asksNavCount;
    }
  }

  #cleanMessagesNotifications() {
    let myHeaders = new Headers();
    myHeaders.append("Accept", "application/json");
    const options = {
      method: 'GET',
      headers: myHeaders
    };
    fetch(`${window.location.pathname}/transition`, options)
      .then((reponse) => {
        return reponse.json()
      })
      .then((data) => {

      })
  }
}
