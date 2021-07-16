class CreateDateExpirations < ActiveRecord::Migration[6.0]
  def change
    create_table :date_expirations do |t|
      t.string :fecha_vencimiento, default: 'sin fecha'
      t.boolean :cambio_fecha, default: false
      t.bigint :cantidad_cambiadas, default: 0

      t.timestamps
    end
  end
end
