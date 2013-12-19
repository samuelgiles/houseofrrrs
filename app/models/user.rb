class User < ActiveRecord::Base
	has_many :user_tasks
	has_many :tasks, through: :user_tasks
	has_many :purchases
	has_many :shares
	has_many :unpaid_shares, -> {where paid: nil}, class_name: 'Share'

	def owed_shares

		Share.includes(:purchase).where(purchases: {user_id: self.id}, shares: {paid: nil})

	end

end
