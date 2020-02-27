class RemoveOfReferenceInPaymentSale < ActiveRecord::Migration[6.0]
  def change
    remove_index :payments,:sales_id
    remove_column :payments,:sales_id
  end
end
