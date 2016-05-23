class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    params[:user][:admin] == '1' ? @user.admin = true : @user.admin = false

    if @user.save
      log_in @user
	    flash[:success] = "Welcome to the RolePlay!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:identity_no, :first_name, :last_name,
                                   :email, :password,
                                   :password_confirmation)
    end
end