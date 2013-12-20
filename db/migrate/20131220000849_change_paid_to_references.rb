class ChangePaidToReferences < ActiveRecord::Migration
  def change
  	change_column :shares, :paid, :int
  end
end
