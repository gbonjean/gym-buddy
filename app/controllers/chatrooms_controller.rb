class ChatroomsController < ApplicationController
  def index
    @chatrooms = current_user.owned_events.map(&:chatroom).reject { |c| c.event.bookings.select(&:accepted).map(&:user).empty? }
    @chatrooms << current_user.events.map(&:chatroom)
    @chatrooms = @chatrooms.flatten.sort_by(&:name)
  end

  def show
    @chatroom = Chatroom.find(params[:id])
  end
end
