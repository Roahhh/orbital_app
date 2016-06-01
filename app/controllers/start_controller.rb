class StartController < ApplicationController
	before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :show, :add_str, :add_agi, :add_vit, :add_int]
  before_action :correct_user,   only: [:edit, :update, :add_str, :add_agi, :add_vit, :add_int]
  before_action :admin_user,     only: [:destroy, :create]

  def index
  end

  def town
  end

  def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

  def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user) || current_user.admin?
    end

    def only_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
