class VoucherDetail < ApplicationRecord

  belongs_to :voucher,  optional:true, class_name: 'Voucher', inverse_of: :voucher_details
  belongs_to :product, optional:true, class_name: 'Product', inverse_of: :voucher_details
  validates_presence_of :voucher, :product_id
end
