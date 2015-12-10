class BoardsController < ApplicationController

    before_action :authenticate_user!

	before_filter :check_user, only: [:edit, :update, :destroy]

    def index
        @user = User.friendly.find(params[:user_id])
        @boards = @user.boards
    end

    def new
        @user = User.friendly.find(params[:user_id])
        @board = Board.new
        @user.boards.build
        session[:return_to] ||= request.referer
    end

    def create
        user = User.friendly.find(params[:user_id])
        @board = Board.new board_params
        @board.user_id = current_user.id

        if @board.save
            redirect_to session.delete(:return_to), notice: "Board saved succesfully."
        else
            render 'new', notice: "Error: try again."
        end
    end

    def show
        @user = User.friendly.find(params[:user_id])
        @board = @user.boards.friendly.find(params[:id])
    end

    def edit
        @user = User.friendly.find(params[:user_id])
        @board = @user.boards.friendly.find(params[:id])
    end

    def update
        @user = User.friendly.find(params[:user_id])
        @board = @user.boards.friendly.find(params[:id])
        respond_to do |f|
			if @board.update(board_params)
				f.html {redirect_to @board, notice: "Board updated succesfully."}
				f.json { render :show, status: :ok, location: @board }
			else
				f.html { render :edit }
				f.json { render json: @board.errors, status: :unprocessable_entity }
			end
		end
    end

    def destroy
        @user = User.friendly.find(params[:user_id])
        @board = @user.boards.friendly.find(params[:id])
        @board.destroy
		redirect_to user_boards_path
    end

    private

    def board_params
        params.require(:board).permit(:name,:description)
    end

    def check_user
        if current_user != @board.user
            redirect_to authenticated_root_url, alert: "This board is not yours"
        end
    end

end
