class Share < ActiveRecord::Base
  belongs_to :user
  belongs_to :purchase
  has_one :payment
end
