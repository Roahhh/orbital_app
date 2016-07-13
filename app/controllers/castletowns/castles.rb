class Castletowns::CastlesController < ApplicationController
  before_action :logged_in_user, only: [:index]

  def index
    @clan = current_user.clan
    @town = Town.find_by(name: @clan)
    @castlelvl = @town.castle_lvl
  end
end