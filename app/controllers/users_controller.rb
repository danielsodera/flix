class UsersController < ApplicationController

  before_action :require_signin, except: [:new, :create]
  before_action :require_correct_user, only: [:edit, :update]
  before_action :require_admin, only: [:destroy]

  def index 
    @users = User.non_admins 
  end

  def show
    @user = User.find_by!(username: params[:id])
    @reviews = @user.reviews
    @favourite_movies = @user.favourite_movies 
  end

  def new 
    @user = User.new 
  end 

  def create 
    @user = User.new(user_params)

    if @user.save 
      redirect_to @user, notice: "Thanks for signing up"
      session[:user_id] = @user.id
    else 
      render :new, status: :unprocessable_entity

    end
  end 

  def edit 
  end

  def update 
    if @user.update(user_params) === true
      redirect_to user_path, notice: "User details updated!"
    else 
      render :edit, status: :unprocessable_entity
    end

  end 

  def destroy
    @user = User.find_by!(username: params[:id])
    @user.destroy
    redirect_to root_path, status: :see_other, notice: "Account successfully deleted!"
    
  end

  private

    def require_correct_user
      @user = User.find(params[:id])
      unless current_user?(@user)
        redirect_to movies_path
      end
    end

    def user_params
      params.require(:user).permit(:username, :name, :email, :password, :password_confirmation)
    end
end
