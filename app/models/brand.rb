class Brand < ApplicationRecord
  has_many :products, source: :brand
  accepts_nested_attributes_for :products
end
