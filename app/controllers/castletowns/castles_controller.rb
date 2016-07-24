class Castletowns::CastlesController < ApplicationController
  before_action :logged_in_user, only: [:index]

  def index
    @clan = current_user.clan
    @town = Town.find_by(name: @clan)
    @castlelvl = @town.castle_lvl
    @jobs = Job.where(hidden: false)
    @hiddenjobs = Job.where(hidden: true)
    @index = 0
    @currenthiddenjob = nil
  end
end