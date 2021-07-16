class Payment < ApplicationRecord
  belongs_to :half_payment, optional: true, class_name:'HalfPayment',:inverse_of => :payments,:foreign_key => "half_payment_id"
  has_many :sales #, :inverse_of => :payment
  accepts_nested_attributes_for :sales
  validates_presence_of :half_payment_id
end
