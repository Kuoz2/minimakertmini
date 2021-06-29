class ReferenceProductExpiredate < ActiveRecord::Migration[6.0]
  def change
    add_reference :products, :date_expirations, foreign_keys: true, index:true
  end
end
