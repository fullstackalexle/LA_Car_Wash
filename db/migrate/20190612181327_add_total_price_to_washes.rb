class AddTotalPriceToWashes < ActiveRecord::Migration[5.2]
  def change
    add_column :washes, :total_price, :decimal, default: 0.00
  end
end
