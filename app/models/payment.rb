class Payment < ActiveRecord::Base
  belongs_to :user
  belongs_to :destination_user, :class_name => "User"
  has_many :shares, :class_name => "Share", :foreign_key => "paid"
end
