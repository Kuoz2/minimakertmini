class ChangeColumnDecreaseDefaultSituation < ActiveRecord::Migration[6.0]
  def change
    remove_column :decreases, :solution_boolean
  end
end
