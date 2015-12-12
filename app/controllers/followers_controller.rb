class FollowersController < ApplicationController
    def index
        @user = User.friendly.find(params[:user_id])
        @followers = @user.followers
    end

    def board
        @user = User.friendly.find(params[:user_id])
        @board = @user.boards.friendly.find(params[:board_id])

        @followers = @board.followers
    end
end
