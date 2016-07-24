class Users::AddExpsController < ApplicationController
    before_action :correct_user,   only: [:update]

    def update
      @user = User.find(params[:id])
      @user.add_exp(params[:exp_add].to_i)
      redirect_to @user
    end
end