class Brand < ApplicationRecord
  has_many :products,  class_name: 'Product', through: :products, :source => :brand, dependent: :nullify
  validates_associated :products
 accepts_nested_attributes_for :products
end
