class UsersController < ApplicationController
    before_action :require_current_user!, only: :show
    # before_action :current_viewer_must_be_current_user!, only: :show


    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.new(user_params)

        if @user.save
            login!(@user)
            redirect_to user_url(@user)
        else
            flash[:errors] = @user.errors.full_messages
            render :new
        end
    end

    def show
        @user = User.find_by(id: current_user.id)
        render :show
    end

    private

    def user_params
        params.require(:user).permit(:username, :password)
    end
end
