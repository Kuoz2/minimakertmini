class Role < ApplicationRecord
  has_many :users, :inverse_of => :role
  accepts_nested_attributes_for :users
end
