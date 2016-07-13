class ItemsController < ApplicationController
	before_action :logged_in_user

	def index
		@items = current_user.items
	end
end
