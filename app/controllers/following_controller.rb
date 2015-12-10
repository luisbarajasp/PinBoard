class FollowingController < ApplicationController
    def index
        @user = User.friendly.find(params[:user_id])
        @followings = @user.following_users
    end
end
