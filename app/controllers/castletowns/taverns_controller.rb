class Castletowns::TavernsController < ApplicationController
	before_action :logged_in_user, only: [:index]   
  #before_action :correct_user,   only: [:index, :about]
  #before_action :admin_user,     only: [:destroy, :create]

  include UsersHelper

  def index
  end
end