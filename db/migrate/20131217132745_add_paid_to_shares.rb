class AddPaidToShares < ActiveRecord::Migration
  def change
    add_column :shares, :paid, :DateTime
  end
end
