class Category < ApplicationRecord

  has_many :products,:source => :category
  has_many :voucher_details, source: :category
  accepts_nested_attributes_for :products
  accepts_nested_attributes_for :voucher_details

end
