class AddVendidosVoucher < ActiveRecord::Migration[6.0]
  def change
    add_column :codes, :voucher_vendido, :boolean, :default => false
  end
end
