class UsersController < ApplicationController

  def index
      @users = User.all
  end

  def show
      @user = User.friendly.find(params[:id])
      @pins = @user.pins.order('created_at DESC')

      respond_to do |format|
        format.html # show.html.erb
        format.xml { render :xml => @user }
    end
  end

  def follow
      @user = User.friendly.find(params[:id])
      current_user.follow(@user)

      redirect_to user_path(@user)
  end

  def unfollow
      @user = User.friendly.find(params[:id])
      current_user.stop_following(@user)

      redirect_to user_path(@user)
  end

end
