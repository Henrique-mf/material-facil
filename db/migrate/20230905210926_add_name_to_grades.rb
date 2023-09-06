class AddNameToGrades < ActiveRecord::Migration[7.0]
  def change
    add_column :grades, :name, :string
  end
end
