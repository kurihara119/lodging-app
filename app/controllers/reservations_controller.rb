class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.all.order(created_at: :desc)
  end

  def new
    @user = User.find(params[:reservation][:user_id])
    @room = Room.find(params[:reservation][:room_id])
    @reservation = Reservation.new(reservation_params)
    if @reservation.valid?
      @reservation.stay_day = @reservation.amount_day
      @reservation.total_amount = @reservation.amount_price
      render "new"
    else
      if @reservation.start_day == nil || @reservation.end_day == nil || @reservation.number_people == nil
        flash.now[:alert] = "必須項目を入力してください"
      else
        if (@reservation.start_day < Date.today) || (@reservation.end_day < Date.today)
          flash.now[:alert] = "過去の日付は無効です"
        elsif @reservation.end_day < @reservation.start_day
          flash.now[:alert] = "終了日は開始日より後にしてください"
        end
      end
      render template: "rooms/show", status: :unprocessable_entity
    end
  end

  def create
    @room = Room.find(params[:reservation][:room_id])
    @reservation = Reservation.new(reservation_params)
    @reservation.user_id = current_user.id
    if @reservation.save
      flash[:notice] = "予約しました"
      redirect_to "/reservations/#{@reservation.id}"
    else
      render "new", status: :unprocessable_entity
    end
  end

  def show
    @reservation = Reservation.find(params[:id])
    @room = @reservation.room
  end

  private
  def reservation_params
    params.require(:reservation).permit(:start_day, :end_day, :stay_day, :number_people, :total_amount).merge(user_id: current_user.id, room_id: @room.id)
  end
end
