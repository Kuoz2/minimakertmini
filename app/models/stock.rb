class Stock < ApplicationRecord
  has_many :products, dependent: :destroy, inverse_of: :stock
  #Relacion con el proveedor
  belongs_to :payment, class_name: 'Provider', foreign_key: :provider_id, optional:true
  belongs_to :product, class_name: 'Product', foreign_key: :product_id, optional: true
  accepts_nested_attributes_for  :products, :allow_destroy => true
end
