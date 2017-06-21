class SessionsController < ApplicationController
  def new
  end

  def create
    if @user = User.find_by(email: params[:email])
         if @user.authenticate(params[:password]) # check if password is correct
           # handle logging in
           flash[:success] = "User successfully login"
           session[:user_id] = @user.id
           redirect_to users_path
         else
           # handle "invalid password"
           flash[:error] = "invalid password"
           redirect_to sessions_new_path
         end
       else
         # handle "user not found"
         flash[:error] = "user not found"
         redirect_to new_user_path
       end
  end
end
