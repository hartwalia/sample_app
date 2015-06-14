class User < ActiveRecord::Base
  
  attr_accessor :remember_token #this defines remember_token and creates a getter function automatically
                                #acessor implies reading so getter, its not a mutator, no writing !
  
  before_save { email.downcase! }
  
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  
  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost) #what is cost ? cars performance measured in BHP
                                                #cpu performance measured in cost, so its saying when u encrypt 
                                                #this password, it must take a minimum effort of this much cost so 
                                                #any attacker has to use as much power to crack it
  end
  
  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64 # SecureRandom is a static class, how i know? 
                                # coz i can call the method urlsafe_base64 without having an object
  end
  
  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end
  
end
