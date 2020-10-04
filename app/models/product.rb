class Product < ApplicationRecord
  #RELACION ENTRE EL PRODUCTO Y EL STOCK
  belongs_to :stock, optional: true, class_name: "Stock", inverse_of: :products, :foreign_key => "stock_id"
  #Relacion entre productos y categorias
  belongs_to :category, foreign_key: "category_id", class_name: "Category"
  #Relacion entre productos y marca
  belongs_to :brand, class_name: 'Brand' ,foreign_key: 'brand_id', optional:true
  #Relacion entre el proveedor y el producto.
  belongs_to :payment, class_name: 'Provider', foreign_key: 'provider_id', optional: true

  has_many :decreases

  has_many :voucher_details, inverse_of: :product

  validates_presence_of :category_id, :brand, :stock
  accepts_nested_attributes_for :voucher_details, allow_destroy: true

end
