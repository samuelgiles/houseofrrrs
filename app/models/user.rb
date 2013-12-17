class User < ActiveRecord::Base
	has_many :user_tasks
	has_many :tasks, through: :user_tasks
	has_many :purchases
	has_many :shares
end
