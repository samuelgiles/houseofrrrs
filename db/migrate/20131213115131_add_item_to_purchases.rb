class AddItemToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :item_id, :integer
  end
end
