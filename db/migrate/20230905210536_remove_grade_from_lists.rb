class RemoveGradeFromLists < ActiveRecord::Migration[7.0]
  def change
    remove_column :lists, :grade, :string
  end
end
