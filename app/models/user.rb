class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         # , :trackable

  attr_accessible :email, :password, :password_confirmation, :remember_me, 
                  :username
  
  attr_accessor :login
  attr_accessible :login
  
  has_many :assignments
  has_many :roles, :through => :assignments

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", 
                               { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def role_symbols  
    roles.map do |role|  
      role.name.underscore.to_sym  
    end  
  end  

end
