class Item < ActiveRecord::Base
	has_many :item_assignments, dependent: :destroy
    has_many :users, :through => :item_assignments
end
