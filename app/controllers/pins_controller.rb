class PinsController < ApplicationController
    before_action :find_pin, only: [:show, :edit, :update, :destroy,:like,:unlike]
	before_action :authenticate_user!, except: [:index, :show]

	before_filter :check_user, only: [:edit, :update, :destroy]
  def index
      @pins = Pin.all.order('created_at DESC')
  end

  def new
      @pin = Pin.new
  end

  def create
      @pin = Pin.new pin_params
      @pin.user_id = current_user.id

      if @pin.save
          redirect_to @pin, notice: "Pin saved succesfully."
      else
          render 'new', notice: "Error: try again."
      end
  end

  def edit
  end

  def show
  end

  def update
		respond_to do |f|
			if @pin.update(pin_params)
				f.html {redirect_to @pin, notice: "Pin updated succesfully."}
				f.json { render :show, status: :ok, location: @pin }
			else
				f.html { render :edit }
				f.json { render json: @pin.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@pin.destroy
		redirect_to pins_path
	end

    def like
        @pin.liked_by current_user

        redirect_to :back

    end

    def unlike
        @pin.unliked_by current_user

        redirect_to :back
    end

    private

		def pin_params
			params.require(:pin).permit(:image, :title, :description, :slug)
		end

        def find_pin
			@pin = Pin.friendly.find(params[:id])
		end

		def check_user
			if current_user != @pin.user
				redirect_to authenticated_root_url, alert: "This pin is not yours"
			end
		end
end
