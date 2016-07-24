class Users::RollLucksController < ApplicationController
    before_action :correct_user,   only: [:update]

    def update
      @user = User.find(params[:id])
      @user.roll_luck
      
    end
end