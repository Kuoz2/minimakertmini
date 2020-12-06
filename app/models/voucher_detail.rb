class VoucherDetail < ApplicationRecord
  belongs_to :voucher,  optional:true, class_name: 'Voucher', inverse_of: :voucher_details, foreign_key: "voucher_id"
  belongs_to :product, optional:true, class_name: 'Product', inverse_of: :voucher_details, foreign_key: "product_id"
  belongs_to :category, optional: true, class_name: 'Category'
  validates_presence_of :voucher, :product_id, :product, :category
end
