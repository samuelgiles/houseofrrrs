class ItemsController < ApplicationController
  def overview

    @neededItems = Item.where(needed: true).order("updated_at DESC")

  	@diaryItems = Purchase.where('created_at >= ?', 4.week.ago).order("updated_at desc")

  end

  def create

    @item = Item.find(:first, :conditions => [ "lower(name) = ?", params[:item][:name].downcase ]) || Item.new(:name => params[:item][:name])

    @item.user = current_user
    @item.needed = true

  	if @item.save

        @item.touch

        flash.notice = "Marked item (" + @item.name + ") as needed"

         
        User.where.not(phone: nil).each do |user|

          # set up a client to talk to the Twilio REST API 
          @client = Twilio::REST::Client.new SECRET_KEYS["sms_account_sid"], SECRET_KEYS["sms_auth_token"]
           
          @client.account.messages.create({
            :from => '+441290211291', 
            :to => user.phone, 
            :body => "Houseofrrrs: #{current_user.name} says that we need #{@item.name}",  
          })

        end
        
      	redirect_to action: 'overview'

  	else

		  flash.now.notice = "Couldn't add item"
		  render 'need'

	  end

  end

  def need

  	@itemsJSON = Item.all.to_json
    @newItem = Item.new

  end

  def purchased

    @purchasedItem = Item.new
    @newPurchase = Purchase.new
    @newPurchase.item = @purchasedItem

    @users = User.all

  end

  def createpurchase
    @item = Item.find(:first, :conditions => [ "lower(name) = ?", params[:item][:name].downcase ]) || Item.new(:name => params[:item][:name])
    @item.user = current_user
    @item.needed = false
    @item.save
    @item.touch

    @purchase = Purchase.new
    @purchase.user = current_user
    @purchase.price = params[:purchase][:price]
    @purchase.item = @item

    if @purchase.save

      #For each user in the system we need to create a share:
      @users = User.all
      @users.each do |user|

        @share = Share.new
        @share.user = user
        @share.purchase = @purchase
        @share.price = (@purchase.price.to_f/@users.count.to_f).round(2)
        if user.id == @purchase.user_id
          @share.paid = 0
        end
        @share.save

      end

      User.where.not(phone: nil).each do |user|

        # set up a client to talk to the Twilio REST API 
        @client = Twilio::REST::Client.new SECRET_KEYS["sms_account_sid"], SECRET_KEYS["sms_auth_token"]
         
        @client.account.messages.create({
          :from => '+441290211291', 
          :to => user.phone, 
          :body => "Houseofrrrs: #{current_user.name} says that they have bought #{@item.name}",  
        })

      end

      flash.notice = "Marked item as purchased (" + @item.name + ")"
      redirect_to action: 'overview'

    else

      flash.now.notice = "Couldn't mark item as purchased"
      render 'purchased'

    end
  end

  def removepurchase

    #get purchase
    @purchase = Purchase.find(params[:purchaseid])

    #remove shares
    @purchase.shares.delete_all

    #delete
    flash.notice = "Removed purchase (\"#{@purchase.item.name}\")"
    @purchase.delete

    redirect_to action: 'overview'

  end

end
