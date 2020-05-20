class Product < ApplicationRecord
  belongs_to :category, foreign_key: "category_id", class_name: "Category"
  belongs_to :brand, class_name: 'Brand' ,foreign_key: 'brand_id', optional:true
  belongs_to :stock, optional:true, class_name: "Stock", foreign_key: "stock_id", inverse_of: :products
  has_many :voucher_details, inverse_of: :product
  validates_presence_of :category_id, :brand, :stock
  accepts_nested_attributes_for :voucher_details, allow_destroy: true

#  validates_presence_of :category

  #                    :pvactivacioncatalogo,
   #   :pstockcatalogo,:pstock,
#                       :pdetalle,:pdescripcion,
  #                    :pcodigo,
   #                   :created_at,
    #                  :updated_at,
     #                 :ppicture,
      #                :pactivado,
       #               :on => create
  # validates :brand, :presence => { allow_blank: true, message: "Esto esta vacio xq no entiendo las marcas"}
end
