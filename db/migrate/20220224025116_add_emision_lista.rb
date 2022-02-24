class AddEmisionLista < ActiveRecord::Migration[6.0]
  def change
    add_column :codes, :TVoucher, :boolean, :defualt=> false 
  end
end
