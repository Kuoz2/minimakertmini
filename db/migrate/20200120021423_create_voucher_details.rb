class CreateVoucherDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :voucher_details do |t|
      t.integer :dvcantidad
      t.integer :dvprecio
      t.references :voucher, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
