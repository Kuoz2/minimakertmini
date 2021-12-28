class AddMargenProct < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :margen, :integer, :default => 0
    #Ex:- :default =>''
  end
end
