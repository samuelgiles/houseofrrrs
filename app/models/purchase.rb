class Purchase < ActiveRecord::Base
  belongs_to :user
  belongs_to :item
  has_many :shares

  def shared_with

  	sharedWith = "everyone"
  	
	if self.shares.count != User.count
		
		names = self.shares.collect { |share| share.user.name }
		sharedWith = names.to_sentence

	end	 

	return sharedWith

  end

end
