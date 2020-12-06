class AddRefereBrand < ActiveRecord::Migration[6.0]
  def change
    add_reference :products , :brand, :foreign_key => true, index: true
  end
end
