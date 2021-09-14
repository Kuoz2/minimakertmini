class CreateQuickSales < ActiveRecord::Migration[6.0]
  def change
    create_table :quick_sales do |t|
      t.bigint :cod_product, default: 0
      t.string :nombre_product, default: "sin nombre"
      t.string :fecha_venta, default: "00-00-0000"
      t.bigint :cantidad, default: 0
      t.string :medio_pago, default:"no existe medio de pago"
      t.bigint :precio, default: 0
      t.bigint :efectivo, default:0

      t.timestamps
    end
  end
end
