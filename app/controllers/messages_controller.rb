class MessagesController < ApplicationController
  def index
    @room = Room.find(params[:room_id])
    @message = Message.new

    @messages = @room.messages.includes(:user)
  end

  def create
    # @message = Message.new(message_params)
    # if @message.save
    #   redirect_to room_messages_path(params[:room_id])
    # else
    #   render :index
    # end
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    if @message.save
      # redirect_to でparamsに載せるから@つける
      redirect_to room_messages_path(@room)
    else
      #render 用の全メッセージ取得
      @messages = @room.messages.includes(:user)
      render :index
    end
  end

  private
  def message_params
    # params.require(:message).permit(:content).merge(room_id: params[:room_id], user_id: current_user.id)
    params.require(:message).permit(:content).merge(user_id: current_user.id)
  end

end
