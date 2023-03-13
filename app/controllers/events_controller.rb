class EventsController < ApplicationController
  before_action :set_event, only: %i[show show_update asks asks_update]

  def index
    @events = Event.order(:start_time).select { |e| e.owner == current_user || e.users.include?(current_user) }
  end

  def show
    @gym = @event.gym
    @is_owner = @event.owner == current_user
    @participants = @event.bookings.select(&:accepted).map(&:user)
    @askers = @event.bookings.reject(&:accepted).map(&:user)
    @free_slots = @event.slots - @participants.size
  end

  def show_update
    if params[:ask]
      Booking.create(user: current_user, event: @event)
    elsif params[:cancel]
      booking = Booking.find_by(user: current_user)
      booking.destroy
    elsif params[:delete]
      @event.destroy
      redirect_to events_path, status: :see_other and return
    end
    redirect_to event_path(@event)
  end

  def asks
    @free_slots = params[:slots]
    @asks = @event.bookings.reject(&:accepted)
    # redirect_to event_path(@event) if @asks.empty?
  end

  def asks_update
    @free_slots = params[:slots].to_i
    @booking = Booking.find(params[:booking_id])
    if params[:accepted]
      @booking.accepted = true
      @booking.save!
      @free_slots -= 1
    else
      @booking.destroy
    end
    @event.bookings.reject(&:accepted).each(&:destroy) if @free_slots.zero?
    redirect_to asks_event_path(slots: @free_slots)
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.owner = current_user
    if @event.save
      create_chatroom(@event)
      redirect_to events_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event)
          .permit(:gym_id, :start_time, :end_time, :slots, :musculation, :cardio, :fitness, :same_level, :description)
  end

  def create_chatroom(event)
    Chatroom.create!(
      event: event,
      name: "#{I18n.with_locale(current_user.locale) { I18n.l(event.start_time, format: '%d %B') }} de #{event.start_time.strftime('%Hh%M')} à #{event.end_time.strftime('%Hh%M')}"
    )
  end
end

# <%= I18n.with_locale("fr") { I18n.l(@event.start_time, format: "%d %B") } %></strong>,
#                               de <%= @event.start_time.strftime('%Hh%M') %> à <%= @event.end_time.strftime('%Hh%M')
