class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
    @gym = @event.gym
    @is_owner = @event.owner == current_user
    @participants = @event.bookings.select(&:accepted).map(&:user)
    @askers = @event.bookings.reject(&:accepted).map(&:user)
    @free_slots = @event.slots - @participants.size
  end

  def asks
    @event = Event.find(params[:id])
    @asks = @event.bookings.reject(&:accepted)
    redirect_to event_path(@event) if @asks.empty?
  end

  def asks_update
    @booking = Booking.find(params[:booking_id])
    if params[:accepted]
      @booking.accepted = true
      @booking.save!
    else
      @booking.destroy
    end
    redirect_to asks_event_path
  end
end
