class Castletowns::ItemShopsController < ApplicationController
	before_action :logged_in_user, only: [:index]

	def index
        @location = "Item"
        @items = Item.where(shop: "Item")
        @clan = current_user.clan
        @town = Town.find_by(name: @clan)
        @shoplvl = @town.item_lvl
        @quantity = 0
	end

end