class SessionsController < ApplicationController
 
  def new 
  end

  def create 
    user = User.find_by(email: params[:email_or_username]) || User.find_by(username: params[:email_or_username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id 
      redirect_to (session[:intended_url] || user), notice: "Welcome back #{user.username}"
      session[:intended_url] = nil
    else 
      flash.now[:alert] = "Invalid username/password"
      render :new, status: :unprocessable_entity
    end
  end 

  def destroy
    session[:user_id] = nil
    redirect_to root_path, status: :see_other, notice: "Successfully signed out"
  end


 
end