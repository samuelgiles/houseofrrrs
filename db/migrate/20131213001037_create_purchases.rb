class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.decimal :price
      t.references :user, index: true

      t.timestamps
    end
  end
end
