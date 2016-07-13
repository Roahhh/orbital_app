class ItemsController < ApplicationController
	before_action :logged_in_user

	def index
		@items = current_user.items.where(shop: "Item")
		@weapons = current_user.items.where(body_pt: "Weapon")
		@heads = current_user.items.where(body_pt: "Head")
		@armors = current_user.items.where(body_pt: "Body")
		@boots = current_user.items.where(body_pt: "Boots")

	end
end
