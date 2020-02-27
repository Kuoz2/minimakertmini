class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.integer :pcodigo
      t.string :pdescripcion
      t.string :pdetalle
      t.binary :ppicture
      t.integer :pstock
      t.integer :pstockcatalogo
      t.integer :pvalor
      t.boolean :pvactivacioncatalogo
      t.references :category, null: false, foreign_key: true
      t.references :brand, null: false, foreign_key: true

      t.timestamps
    end
  end
end
