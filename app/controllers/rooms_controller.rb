class RoomsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @rooms = Room.all
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    @room.user_id = current_user.id
    if @room.save
      redirect_to "/rooms/posts"
    else
      flash.now[:alert] = "ルーム情報を入力してください"
      render "new", status: :unprocessable_entity
    end
  end

  def show
    @room = Room.find(params[:id])
    @reservation = Reservation.new
    @user = current_user
  end

  def search
    if params[:address].present?
      @search = Room.where("address LIKE ? ", "%#{params[:address]}%")
    elsif params[:room_text].present?
      @search = Room.where('room_text LIKE ?', "%#{params[:room_text]}%")
    elsif (params[:address] == nil || '') || (params[:room_text] == nil || '')
      @search = Room.all
    else
      @search = Room.all
    end
  end

  def posts
    @room = Room.where(user_id: current_user.id).includes(:user).order(created_at: :desc)
  end

  private
  def room_params
    params.require(:room).permit(:room_name, :room_text, :price, :address, :image)
  end
end
