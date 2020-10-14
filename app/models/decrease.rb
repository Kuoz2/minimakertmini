class Decrease < ApplicationRecord
  belongs_to :product, optional:true
  validates_presence_of :product_id
end
