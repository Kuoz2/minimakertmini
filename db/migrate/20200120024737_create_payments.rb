class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.integer :pagomonto
      t.integer :pagovuelto
      t.references :half_payment, null: false, foreign_key: true
      t.references :sales, null: false, foreign_key: true

      t.timestamps
    end
  end
end
