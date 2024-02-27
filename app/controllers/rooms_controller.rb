class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @room = Room.new
    @rooms = Room.public_room
    @users = User.all_except(current_user)
  end

  def show
    @single_room = Room.find(params[:id])
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

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@room) }
    end
  end

  private

  def room_params
    params.require(:room).permit(:name)
  end
end
