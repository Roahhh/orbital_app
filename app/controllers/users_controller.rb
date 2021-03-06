class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :show]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:destroy, :create]

  include UsersHelper

  def new
  	@user = User.new
  end

  def destroy
    User.find(params[:id]).destroy
    @quests =  Quest.where(user_id: params[:id])

    @quests.each do |quest|
      quest.destroy
    end
    
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def index
    @users = User.paginate(page: params[:page]).order('first_name ASC')
  end
  
  def show
    @user = User.find(params[:id])
    @quests = @user.quests.paginate(page: params[:page])
    @createdquests = Quest.where(user_id: params[:id])
    @weapon = @user.eqp_wpn == nil ? nil : Item.find(@user.eqp_wpn)
    @head = @user.eqp_head == nil ? nil : Item.find(@user.eqp_head)
    @body = @user.eqp_body == nil ? nil : Item.find(@user.eqp_body)
    @boots = @user.eqp_boots == nil ? nil : Item.find(@user.eqp_boots)
  end

  def create
    @user = User.new(user_params)
    class_no = @user.class_no % 4
    clan_name = class_no == 1 ? "Zeus" : 
                class_no == 2 ? "Odin" :
                class_no == 3 ? "Thor" :
                class_no == 4 ? "Ares" :
                "Neutral"

    params[:user][:luck] == rand(100)
    @user.clan = clan_name
    params[:user][:admin] == '1' ? @user.admin = true : @user.admin = false

    if @user.save
	    flash[:success] = "New User, " + @user.first_name + " " + @user.last_name + " created!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user    
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:identity_no, :first_name, :last_name, :class_no, :year,
                                   :email, :password,
                                   :password_confirmation)
    end
end