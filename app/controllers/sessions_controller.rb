class SessionsController < ApplicationController
    def new
        render :new
    end

    def create
        user = User.find_by_credentials(
            params[:user][:username],
            params[:user][:password]
        )

        if user.nil?
            flash[:errors] = "The username or password is incorrect"
            render :new
        else
            redirect_to user_url(user)
        end
    end
end
