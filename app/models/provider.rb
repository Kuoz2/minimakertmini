class Provider < ApplicationRecord
  has_many :products#, :inverse_of => :providers
  has_many :stocks#, :inverse_of => :providers
  accepts_nested_attributes_for :products, :stocks
end
