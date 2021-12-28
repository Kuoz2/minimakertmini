class AddUtilitieesToProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :utilidad, :integer, :default => 0
  end
end
