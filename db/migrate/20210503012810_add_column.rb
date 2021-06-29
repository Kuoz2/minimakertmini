class AddColumn < ActiveRecord::Migration[6.0]
  def change
    add_column :decreases, :solution_boolean, :boolean, default: false, null: false
  end
end
