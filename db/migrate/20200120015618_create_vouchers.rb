class CreateVouchers < ActiveRecord::Migration[6.0]
  def change
    create_table :vouchers do |t|
      t.integer :vnumerodebusqueda
      t.integer :vtotal

      t.timestamps
    end
  end
end
