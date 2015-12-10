class FollowersController < ApplicationController
    def index
        @user = User.friendly.find(params[:user_id])
        @followers = @user.followers
    end
end
