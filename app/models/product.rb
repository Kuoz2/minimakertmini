class Product < ApplicationRecord
  belongs_to :category, foreign_key: "category_id", class_name: "Category", dependent: :destroy, optional:true
  belongs_to :brand, class_name: 'Brand' ,foreign_key: 'brand_id', optional:true
  has_many :voucher_details, inverse_of: :product
  accepts_nested_attributes_for :voucher_details
#  validates_presence_of :category
validates_presence_of :category_id, :brand
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
