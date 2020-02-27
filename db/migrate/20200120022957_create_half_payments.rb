class CreateHalfPayments < ActiveRecord::Migration[6.0]
  def change
    create_table :half_payments do |t|
      t.string :mpnombre

      t.timestamps
    end
  end
end
