class AddStockSaveReferenfeceProduct < ActiveRecord::Migration[6.0]
  def change
    add_reference :stocks, :product, :index => true, foreign_keys: true
  end
end
