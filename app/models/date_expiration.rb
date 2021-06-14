class DateExpiration < ApplicationRecord
  has_many :products,  dependent: :destroy, inverse_of: :date_expiration
  accepts_nested_attributes_for   :products, :allow_destroy => true
end
