class DateExpiration < ApplicationRecord
  has_many :products, inverse_of: :date_expiration
  accepts_nested_attributes_for :products
end
