class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.monetize :amount, currency: { present: false }
      t.string :checkout_session_id
      t.string :state
      t.references :cart, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
