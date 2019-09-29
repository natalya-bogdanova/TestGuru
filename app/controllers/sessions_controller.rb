class SessionsController < ApplicationController
  def new
  end

  def create
   user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to cookies.delete(:path) || tests_path
    else
      flash.now[:alert] = 'Are You a Guru? Verify your Email and Password please'
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to login_path
  end
end