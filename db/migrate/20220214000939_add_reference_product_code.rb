class AddReferenceProductCode < ActiveRecord::Migration[6.0]
  def change
    add_reference :codes , :product, index: true, foreign_key: true 
  end
end
