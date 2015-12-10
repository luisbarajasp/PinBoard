class ItsController < ApplicationController
  def new
      @pin = Pin.friendly.find(params[:pin_id])
      @it = It.new
      @pin.its.build
  end

  def create
      @pin = Pin.friendly.find(params[:pin_id])
      @it = It.new it_params
      @it.pin_id = @pin.id

      if @it.save
          redirect_to user_boards_path(current_user), notice: "Pinned it succesfully."
      else
          render 'new', notice: "Error: try again."
      end
  end

  def destroy
      pin = Pin.friendly.find(params[:pin_id])
      @it.destroy
      redirect_to pin_path(pin)
  end

  private

  def it_params
      params.require(:it).permit(:board_id)
  end
end
