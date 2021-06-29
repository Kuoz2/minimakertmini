class ChangeColumnProductFechavencimiento < ActiveRecord::Migration[6.0]
  def change
    change_column :products, :fecha_vencimiento, :string
  end
end
