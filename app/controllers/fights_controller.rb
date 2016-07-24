class FightsController < ApplicationController
	before_action :logged_in_user
  before_action :qualified_user, only: [:index, :combat]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:destroy, :create]
  before_action :dead_user,      only: [:death]

  def index
     current_user
     flash[:danger] = random_message
     @monster = Monster.random_encounter
     @monster.cur_hp = @monster.max_hp
     @monster.save
     session[:monster_id] = @monster.id
  end

  def combat
    current_user
    @monster = Monster.find(session[:monster_id])
    @user = current_user
    @user_dmg = @user.att_value + rand(-3..3)
    @monster_dmg = @monster.attack + rand(-3..3)
    @user.curr_hp = @user.curr_hp - @monster_dmg
    @monster.cur_hp = @monster.cur_hp - @user_dmg
    if @user.curr_hp < 0
      @user.curr_hp = 0
    end

    if @monster.cur_hp < 0
      @monster.cur_hp = 0
    end
    @user.save
    @monster.save

  end

  def death
    current_user
    flash[:danger] = death_message
    session[:monster_id] = nil
    current_user.curr_hp = current_user.hp
    current_user.save
  end

  def drops
    flash[:success] = "Your victory has made you confident"
    session[:monster_id] = nil
    redirect_to starts_path

  end



  def qualified_user
  	#user.runs > 0
  	store_location
    unless current_user.curr_hp > 0 || current_user.admin?

      if current_user.curr_hp == 0
			  flash[:danger] = "You do not have sufficient HP"

      end
    end
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

  def dead_user
    redirect_to starts_path unless current_user.curr_hp <= 0
  end

  private

  def random_message
    @messages = ["A devilish presence has appeared", "You sense a hostile intent directed towards you", "You stumbled across the path of a wandering monster"]
    return @messages.sample
  end

  def death_message
    @death_messages = ["You have been slain in battle", "Thou hath died a gruesome death", "Your vision becomes enshrouded with darkness", "The reaper claims your soul"]
    return @death_messages.sample
  end  
end
