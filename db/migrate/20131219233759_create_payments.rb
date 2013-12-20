class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :user, index: true
      t.integer :destination_user_id, index: true
      t.decimal :amount

      t.timestamps
    end
  end
end
