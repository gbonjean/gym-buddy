import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="notification-subscription"
export default class extends Controller {
  static values = { currentUserId: Number }

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "NotificationChannel" },
      { received: data => console.log(data) }
    )
    console.log(`Subscribe to the notifications for ${this.currentUserIdValue}`)
  }

}
