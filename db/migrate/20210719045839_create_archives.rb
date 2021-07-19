class CreateArchives < ActiveRecord::Migration[6.0]
  def change
    create_table :archives do |t|
      t.binary :nombreXML

      t.timestamps
    end
  end
end
