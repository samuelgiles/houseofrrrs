class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.references :user, index: true
      t.references :purchase, index: true
      t.decimal :price

      t.timestamps
    end
  end
end
