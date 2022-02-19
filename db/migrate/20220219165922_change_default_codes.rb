class ChangeDefaultCodes < ActiveRecord::Migration[6.0]
  def change
    add_column :codes, :cod_panaderia, :bigint, :default =>  1
    add_column :codes, :cod_market,:bigint, :default => 1
  end
end
