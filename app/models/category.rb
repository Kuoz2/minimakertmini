class Category < ApplicationRecord

  has_many :products,:source => :category
  accepts_nested_attributes_for :products


end
