class Product < ApplicationRecord
  #RELACION ENTRE EL PRODUCTO Y EL STOCK
  belongs_to :stock, inverse_of: :products, foreign_key: :stock_id
  #Relacion entre productos y categorias
  belongs_to :category, foreign_key: "category_id", class_name: "Category"
  #Relacion entre el proveedor y el producto.
  belongs_to :payment, class_name: 'Provider', foreign_key: 'provider_id', optional: true
  #Relacion entre los impuestos y el producto.
  belongs_to :tax, class_name: 'Tax', foreign_key: 'tax_id'
  belongs_to :brand, foreign_key: "brand_id", class_name: "Brand"
  belongs_to :date_expiration,  foreign_key: :date_expirations_id, optional: true, :inverse_of => :products
  has_many :decreases
  has_many :voucher_details, inverse_of: :product
  has_many :stocks
  has_many :date_expirations, inverse_of: :products, foreign_key: :date_expirations_id
  validates_presence_of :category_id,:stock, :brand_id, :date_expiration


  accepts_nested_attributes_for :voucher_details, allow_destroy: true
  accepts_nested_attributes_for :decreases
  accepts_nested_attributes_for :stocks
  accepts_nested_attributes_for :date_expirations


end
