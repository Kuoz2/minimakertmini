class AddReferenceSolution < ActiveRecord::Migration[6.0]
  def change
    add_reference :mrmsolutions , :decrease, :index => true, foreign_keys: true
  end
end
