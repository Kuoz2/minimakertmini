class CreateMrmsolutions < ActiveRecord::Migration[6.0]
  def change
    create_table :mrmsolutions do |t|
      t.string :mrmsolucion
      t.string :mrmfechasolucion
      t.bigint :cantidad_veces_cometido

      t.timestamps
    end
  end
end
