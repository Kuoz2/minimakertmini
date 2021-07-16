class AddFechaVencimientoProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :fecha_vencimiento, :date
  end
end
