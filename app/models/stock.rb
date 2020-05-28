class Stock < ApplicationRecord
  has_many :products, :inverse_of => :stock

           accepts_nested_attributes_for :products
end
