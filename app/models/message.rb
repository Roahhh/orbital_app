class Message < ActiveRecord::Base
	belongs_to :user
	has_many :comments, dependent: :destroy

	validates :title, presence: true
	validates :description, presence: true
end
