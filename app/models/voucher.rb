class Voucher < ApplicationRecord

  has_many :voucher_details,
           class_name: 'VoucherDetail',
           :dependent => :destroy,
           :inverse_of => :voucher
  has_many :payments , :through => :payments
  has_many :sales, through: :sales, :inverse_of => :voucher
  accepts_nested_attributes_for :voucher_details, reject_if: :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :sales,reject_if: :all_blank, :allow_destroy => true

end
