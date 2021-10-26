class RemoveColumnProvider < ActiveRecord::Migration[6.0]
  def change
    remove_column :providers, :direccion_provider
    remove_column :providers, :comuna_provider
    remove_column :providers, :telefono_provider
    remove_column :providers, :telefono_persona_provider
    remove_column :providers, :correo_provider
    remove_column :providers, :contabilidad_provider
    remove_column :providers, :banco_provider
    remove_column :providers, :factura_provider
  end
end
