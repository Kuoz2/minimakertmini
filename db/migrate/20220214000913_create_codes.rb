class CreateCodes < ActiveRecord::Migration[6.0]
  def change
    create_table :codes do |t|
      t.string :hora_emision, default: ""
      t.boolean :market, default: false
      t.boolean :panaderia, default: false      
      t.bigint :cod_market, default: 0
      t.bigint :cod_panaderia, default:0
      t.timestamps
    end
  end
end
