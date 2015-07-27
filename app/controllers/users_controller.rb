class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create, :login, :sign_in, :logout]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "You have been successfully logged in!"
      session[:user_id] = @user.id
      redirect_to user_fileuploads_path(@user)
    else
      flash[:error] = "User creation failed. Please recheck the form inputs."
      render 'new'
    end
  end

  def login
    @user = User.new
  end

  def sign_in
    @user = User.authenticate(user_params[:user_name], user_params[:password])

    if @user
      session[:user_id] = @user.id
      flash[:notice] = "You have successfully signed in!"
      redirect_to user_fileuploads_path(@user)
    else
      @user = User.new
      flash[:error] = "Sign in failed"
      render :action => "login"
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "You have successfully logged out."
    redirect_to :root
  end

  private
    def user_params
      params.require(:user).permit(:user_name, :password, :password_confirmation)
    end
end
