class AddRefereFechaExpiration < ActiveRecord::Migration[6.0]
  def change
    add_reference :date_expirations, :product, :index => true, foreign_keys: true, :dafault=> 0
  end
end
