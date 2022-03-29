class AddValorPvalor < ActiveRecord::Migration[6.0]
  def change
    add_column :codes, :pvalor, :bigint, :default => 0
    #Ex:- :default =>''
  end
end
