class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(identity_no: params[:session][:identity_no].upcase)
    if user && user.authenticate(params[:session][:password])
    	log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash.now[:danger] = 'Invalid user/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
