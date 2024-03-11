class MessagesController < ApplicationController

  def create_table
    @message = current_user.messages.create(body: msg_parms[:body], room_id: params[:room_id])
  end

  private

  def msg_params
    params.require(:message).permit(:body)
  end
end
