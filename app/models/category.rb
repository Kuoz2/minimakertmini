class Category < ApplicationRecord
  has_many :products#,:source => :category
  accepts_nested_attributes_for :products
  attr_accessor :verificacion_jtil
  after_save :recargar
  def recargar
    category.reloaded
  end
end
