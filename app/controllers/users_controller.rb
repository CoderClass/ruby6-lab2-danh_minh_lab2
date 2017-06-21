class UsersController < ApplicationController

  def new
    @user = User.new
  end

  # POST /users
  def create
    @user = User.new(user_params)
    @user.image_url = Faker::Avatar.image("#{@user.name}", "50x50", "jpg")
    if @user.save
      flash[:success] = "User successfully created"
      session[:user_id] = @user.id
      redirect_to users_path # create user, let user in and redirect to /users
    else
      flash[:error] = "Error: #{@user.errors.full_messages.to_sentence}"
      redirect_to new_user_path
    end
  end

  def index
    @users = User.all.shuffle
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end


end
