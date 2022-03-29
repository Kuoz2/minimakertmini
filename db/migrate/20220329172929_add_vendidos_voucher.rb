class AddVendidosVoucher < ActiveRecord::Migration[6.0]
  def change
    add_column :code, :voucher_vendido, :boolean, :default => false
  end
end
