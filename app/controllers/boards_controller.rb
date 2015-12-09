class BoardsController < ApplicationController
    before_filter :find_board, only: [:show,:edit,:update,:destroy]
    before_action :authenticate_user!

    before_filter :get_user

	before_filter :check_user, only: [:edit, :update, :destroy]

    def index
        @user = User.friendly.find(params[:user_id])
        @boards = @user.boards
    end

    def new
        user = User.friendly.find(params[:user_id])
        @board = Board.new
        @board.user.build
    end

    def create
        user = User.friendly.find(params[:user_id])
        @board = Board.new board_params
        @board.user_id = current_user.id

        if @board.save
            redirect_to user_boards_path, notice: "Board saved succesfully."
        else
            render 'new', notice: "Error: try again."
        end
    end

    def show
        user = User.friendly.find(params[:user_id])
    end

    def edit
        user = User.friendly.find(params[:user_id])
    end

    def update
        user = User.friendly.find(params[:user_id])
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
        user = User.friendly.find(params[:user_id])
        @board.destroy
		redirect_to user_boards_path
    end

    private

    def board_params
        params.require(:board).permit(:name,:description)
    end

    def find_board
        @board = user.board.friendly.find(params[:id])
    end

    def check_user
        if current_user != @board.user
            redirect_to authenticated_root_url, alert: "This board is not yours"
        end
    end

    def get_user

    end

end
