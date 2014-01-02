class PurchasesController < ApplicationController
  def overview
  	@userBalances = User.all
  	@recentPayments = Payment.where('created_at >= ?', 4.week.ago).order("updated_at desc")
  end

  def payuser

  	#Try to find user:
  	@destinationUser = User.find(params[:pay_user_id])

  	if @destinationUser

	  	#Work out what the user owes
	  	unpaidSharesForDestinationUser = @destinationUser.owed_shares.where(shares: {user_id: current_user.id})
	  	owes = unpaidSharesForDestinationUser.sum('price')

	  	@payment = Payment.new
	  	@payment.user = current_user
	  	@payment.destination_user = @destinationUser
	  	@payment.amount = owes
	  	@payment.save

	  	if @destinationUser.phone != nil

	        # set up a client to talk to the Twilio REST API 
	        @client = Twilio::REST::Client.new SECRET_KEYS["sms_account_sid"], SECRET_KEYS["sms_auth_token"]
	         
	        @client.account.messages.create({
	          :from => '+441290211291', 
	          :to => @destinationUser.phone, 
	          :body => "Houseofrrrs: #{current_user.name} says that they have paid you #{number_to_currency(owes,unit:"&pound;")}",  
	        })

    	end

	  	#Save payment
	  		#Mark all shares as done
	  	unpaidSharesForDestinationUser.each do |share|
	  		share.paid = @payment.id
	  		share.save
	  	end

	  	#flash.notice = "Paid share of #{unpaidSharesForDestinationUser.count} #{pluralize(unpaidSharesForDestinationUser.count, 'item')} at #{number_to_currency(owes, "£")} to #{@destinationUser.name}" 
      	redirect_to action: 'overview'

  	end

  end

end
