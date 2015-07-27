class User < ActiveRecord::Base
  has_many :fileuploads, dependent: :destroy

  validates_uniqueness_of :user_name 
  validates_confirmation_of :password
  validates :password_hash, presence: true
  validates :user_name, presence: true, length: { minimum: 5 }

  attr_accessor :password, :password_confirmation

  def password=(value)
    @password = value
    self.password_salt = BCrypt::Engine.generate_salt if self.password_salt.nil?
    self.password_hash = BCrypt::Engine.hash_secret(value, password_salt)
  end

  def self.authenticate(user_name, password)
    user = find_by_user_name(user_name)

    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
end
