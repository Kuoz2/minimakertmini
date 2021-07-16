class HalfPayment < ApplicationRecord
  has_many :payments#, inverse_of: :half_payment
  accepts_nested_attributes_for :payments, reject_if: :all_blank, :allow_destroy => true
end
