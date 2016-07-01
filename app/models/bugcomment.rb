class Bugcomment < ActiveRecord::Base
  belongs_to :bugreport
  belongs_to :user
end
