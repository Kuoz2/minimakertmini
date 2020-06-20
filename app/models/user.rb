class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self
#before_save :encryptar_role
#private
 # def encryptar_role
  #  l = Digest::SHA2.new(256)
   # l<<self.role
    #self.role = l.hexdigest
  #end
end
