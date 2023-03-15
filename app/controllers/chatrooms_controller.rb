class ChatroomsController < ApplicationController
  def index
    @chatrooms = current_user.owned_events.map(&:chatroom).reject { |c| c.event.bookings.select(&:accepted).map(&:user).empty? }
    @chatrooms << current_user.events.map(&:chatroom)
    @chatrooms = @chatrooms.flatten.sort_by(&:name)
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
  end

  def transition
    @chatroom = Chatroom.find(params[:id])
    current_user.messages_notifications.each { |n| n.destroy if n.params[:message] == @chatroom.id }
    respond_to do |format|
      format.html { redirect_to chatroom_path(@chatroom) }
      format.json {
        render json: { content: '[1]' }.to_json
      }
    end
  end
end
