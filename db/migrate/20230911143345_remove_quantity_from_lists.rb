class RemoveQuantityFromLists < ActiveRecord::Migration[7.0]
  def change
    remove_column :lists, :quantity, :integer
  end
end
