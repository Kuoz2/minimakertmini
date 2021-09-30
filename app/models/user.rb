class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self
  def generate_jwt
    JWT.encode({id: id, exp: 3.day.to_i}, Rails.application.secrets.secret_key_base)
  end
  def jwt_payload
    { 'role' => role}
   
  rescue
    nil
  end


#before_save :encryptar_role
#private
 # def encryptar_role
  #  l = Digest::SHA2.new(256)
   # l<<self.role
    #self.role = l.hexdigest
  #end

end
