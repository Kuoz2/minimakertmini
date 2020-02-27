class AddReferenceVoucherSales < ActiveRecord::Migration[6.0]
  def change
    add_reference(:sales, :voucher, :foreing_key => true, :index => true)
    add_reference(:sales, :payment,:foreing_key => true, index: true)
  end

end
