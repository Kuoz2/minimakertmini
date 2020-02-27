class AddPvactivadoSales < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :pactivado, :boolean
  end
end
