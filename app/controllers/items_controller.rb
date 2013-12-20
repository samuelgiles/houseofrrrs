class ItemsController < ApplicationController
  def overview

    @neededItems = Item.where(needed: true).order("updated_at DESC")

  	@diaryItems = Purchase.where('created_at >= ?', 4.week.ago).order("updated_at desc")

  end

  def create

  	@item = Item.find_or_initialize_by(name: params[:item][:name])

    @item.user = current_user
    @item.needed = true

  	if @item.save

        @item.touch

        flash.notice = "Marked item (" + @item.name + ") as needed"
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

  end

  def createpurchase
    @item = Item.find_or_initialize_by(name: params[:item][:name])
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
        @share.price = (@purchase.price/@users.count).round(2)
        if user.id == @purchase.user_id
          @share.paid = 0
        end
        @share.save

      end

      flash.notice = "Marked item as purchased (" + @item.name + ")"
      redirect_to action: 'overview'

    else

      flash.now.notice = "Couldn't mark item as purchased"
      render 'purchased'

    end
  end

end
