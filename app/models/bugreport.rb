class Bugreport < ActiveRecord::Base
	belongs_to :user
	has_many :bugcomments, dependent: :destroy

	validates :title, presence: true
	validates :description, presence: true
end
