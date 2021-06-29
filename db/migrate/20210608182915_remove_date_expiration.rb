class RemoveDateExpiration < ActiveRecord::Migration[6.0]
  def change
    remove_column :date_expirations, :stock_expiration
    remove_column :date_expirations, :actualizado_stockm
  end
end
