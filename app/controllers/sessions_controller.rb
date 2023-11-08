class SessionsController < ApplicationController
    # Login
    def new
    end

    def create
        user_name = user_params[:user_name]
        password = user_params[:password]
        user = User.find_by(user_name:user_name)
        if user != nil and user.authenticate(password)
            session[:user_id] = user.id
            redirect_to root_path
        else
            flash[:warning] = "Wrong password or username!"
            redirect_to new_session_path
        end
    end

    private
    # Making "internal" methods private is not required, but is a common practice.
    # This helps make clear which methods respond to requests, and which ones do not.
    def user_params
        params.require(:user).permit(:user_name, :password)
    end
end