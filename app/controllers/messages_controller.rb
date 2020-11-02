# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
      @room = Room.find(params[:id])
      @message = Message.create!(message_params)
      ActionCable.server.broadcast 'room_channel', message: @message.template
      redirect_to "/rooms/#{@message.room_id}"
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :content, :room_id).merge(user_id: current_user.id)
  end
end
