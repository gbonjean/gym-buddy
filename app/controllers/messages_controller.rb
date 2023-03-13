class MessagesController < ApplicationController

  def create
    @chatroom = Chatroom.find(params[:chatroom_id])
    @message = Message.new(message_params)
    @message.chatroom = @chatroom
    @message.user = current_user
    if @message.save
      notify_new_message(@chatroom)
      ChatroomChannel.broadcast_to(
        @chatroom,
        message: render_to_string(partial: "message", locals: {message: @message}),
        sender_id: @message.user.id
      )
      head :ok
      # redirect_to chatroom_path(@chatroom)
    else
      render "chatrooms/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def notify_new_message(chatroom)
    owner = chatroom.event.owner
    chatroom.event.users.each do |user|
      MessageNotification.with(message: chatroom.id).deliver_later(user) unless user == current_user
    end
    MessageNotification.with(message: chatroom.id).deliver_later(owner) unless owner == current_user
  end
end
