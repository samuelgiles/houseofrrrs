class Payment < ActiveRecord::Base
  belongs_to :user
  belongs_to :destination_user, :class_name => "User"
  has_many :shares, :class_name => "Share", :foreign_key => "paid"

  #create a Barclays Ping It URI for the payment
  def barclaysPingItURI

  	#barclays://08/07543651833/3.50/07543651833//
  	mode = "08"
  	destinationNumber = self.user.phone
  	setPrice = self.amount
  	confirmNumber = self.destination_user.phone
  	uri = "barclays://#{mode}/#{destinationNumber}/#{setPrice}/#{confirmNumber}"

  end

end
