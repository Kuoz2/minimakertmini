class DateExpiration < ApplicationRecord
  has_many :products  #dependent: :destroy, inverse_of: :date_expiration
  belongs_to :product, class_name: 'Product', foreign_key: :product_id, optional: true
  accepts_nested_attributes_for :products, :allow_destroy => true
end
