class Sale < ApplicationRecord
  belongs_to :voucher, optional: true, class_name: "Voucher", inverse_of: :sales
  belongs_to :payment, optional: true, class_name: "Payment", inverse_of: :sales
  validates_presence_of :payment,:voucher_id
end
