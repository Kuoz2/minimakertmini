class Mrmsolution < ApplicationRecord
  belongs_to :decrease, foreign_key: 'decrease_id', class_name: 'Decrease'
end
