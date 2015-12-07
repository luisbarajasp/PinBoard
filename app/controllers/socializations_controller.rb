class SocializationsController < ApplicationController
  def like
      current_user.like!(Pin.find(id))
      render json: { like: true }
  end

  def dislike
      current_user.unlike!(Pin.find(id))
      render json: { like: false }
  end

end
