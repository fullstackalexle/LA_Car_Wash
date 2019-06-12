class CreateWashes < ActiveRecord::Migration[5.2]
  def change
    create_table :washes do |t|
      t.references :vehicle, foreign_key: true
      t.decimal :sales_price
      t.boolean :discount, default: false
      t.decimal :discount_percentage, default: 0.00
      t.decimal :discount_value, default: 0.00

      t.timestamps
    end
  end
end
