class FollowingController < ApplicationController
    def index
        @user = User.friendly.find(params[:user_id])
        @followings = @user.following_users
    end
    def board
        @user = User.friendly.find(params[:user_id])
        @followings = @user.following_boards
    end
end
