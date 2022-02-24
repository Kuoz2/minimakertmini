class AddPrecioiva < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :preciva, :bigint, :default => 0
    #Ex:- :default =>''
  end
end
