class RemoveOtherColumnProvider < ActiveRecord::Migration[6.0]
  def change
    remove_column :providers, :rut_provider
    remove_column :providers, :web_provider
    remove_column :providers, :detalle_provider
  end
end
