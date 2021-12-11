class Category < ApplicationRecord
  has_many :products#,:source => :category
  accepts_nested_attributes_for :products
  attr_accessor :verificacion_jtil

end
