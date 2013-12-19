class PurchasesController < ApplicationController
  def overview
  	@userBalances = User.all
  end
end
