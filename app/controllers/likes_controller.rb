class LikesController < ApplicationController
  def index
      @user = User.friendly.find(params[:user_id])
      @pins = @user.find_liked_items
  end
end
