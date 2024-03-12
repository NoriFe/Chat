class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @room = Room.new
    @rooms = Room.public_room
    @users = User.all_except(current_user)
    render 'index'
  end

  def show
    @single_room = Room.find(params[:id])
    @room = Room.new
    @rooms = Room.public_room
    @message = Message.new
    @messages = @single_room.messages.order(created_at: :asc)
    @users = User.all_except(current_user)
    render 'index'
  end

  def destroy
    @room = Room.find(params[:id])
    @room.messages.destroy_all # Delete associated messages
    @room.destroy
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@room) }
      format.html { redirect_to root_path, notice: 'Room was successfully deleted.' }
    end
  end

  def create
    @room = Room.new(room_params)

    respond_to do |format|
      if @room.save
        format.turbo_stream { render turbo_stream: turbo_stream.append(:rooms, partial: 'rooms/room', locals: { room: @room }) }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace('flash-messages', partial: 'layouts/flash_messages', locals: { flash: flash }) }
      end
    end
  end

  private

  def room_params
    params.require(:room).permit(:name)
  end
end
