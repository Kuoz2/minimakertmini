class AdDStockFecha < ActiveRecord::Migration[6.0]
  def change
    add_column :date_expirations, :stock_expiration, :bigint, default: 0
    add_column :date_expirations, :actualizado_stockm, :boolean, default: false
  end
end
