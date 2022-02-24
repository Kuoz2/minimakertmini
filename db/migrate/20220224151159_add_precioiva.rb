class AddPrecioiva < ActiveRecord::Migration[6.0]
  def change
    add_column :product, :preciva, :bigint, :default => 0
    #Ex:- :default =>''
  end
end
