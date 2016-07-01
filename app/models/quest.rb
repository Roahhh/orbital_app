class Quest < ActiveRecord::Base
	has_many :quest_assignments, dependent: :destroy
    has_many :users, :through => :quest_assignments

    accepts_nested_attributes_for :quest_assignments


	validates :title, presence: true
	validates :description, presence: true
end
