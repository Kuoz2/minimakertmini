class Decrease < ApplicationRecord
  belongs_to :product, optional:true
  has_many :mrmsolutions
  validates_presence_of :product_id
  accepts_nested_attributes_for :mrmsolutions
end
