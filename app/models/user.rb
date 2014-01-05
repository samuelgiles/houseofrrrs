class User < ActiveRecord::Base
	has_many :user_tasks
	has_many :tasks, through: :user_tasks
	has_many :purchases
	has_many :shares
	has_many :unpaid_shares, -> {where paid: nil}, class_name: 'Share'
	has_many :payments

	def owed_shares

		Share.includes(:purchase).where(purchases: {user_id: self.id}, shares: {paid: nil})

	end

	#When splitting up an item we look at whether the user will pay a share:
	attr_accessor :will_pay_share

end
