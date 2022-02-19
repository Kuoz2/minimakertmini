class RemoverColumnCodes < ActiveRecord::Migration[6.0]
  def change
    remove_column :codes, :cod_market
    remove_column :codes, :cod_panaderia
    #Ex:- change_column("admin_users", "email", :string, :limit =>25) :code,
  end
end
