class CreateGrades < ActiveRecord::Migration[7.0]
  def change
    create_table :grades do |t|
      t.references :school, null: false, foreign_key: true

      t.timestamps
    end
  end
end
