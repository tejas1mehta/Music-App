class User < ActiveRecord::Base
  attr_reader :password

  validates :password_digest, :email, :session_token, presence: true
  validates :password, :length => { :minimum => 6, :allow_nil => true }
  validates :email, :session_token, :activation_token, uniqueness: true
  before_validation :ensure_token
  before_validation :give_activation_token

  def self.create_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def reset_token_password!
    self.session_token = SecureRandom::urlsafe_base64(16)
    self.save!
    self.session_token
  end

  def password= (unencrypted_password)
    if unencrypted_password.present?
      @password = unencrypted_password
      self.password_digest = BCrypt::Password.create(unencrypted_password)
    end
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(email_find, password_find)
    user = User.find_by_email(email_find)

    if user && user.is_password?(password_find)
      return user
    else
      return nil
    end

  end

  private

  def ensure_token
    self.session_token ||= User.create_session_token
  end

  def give_activation_token
    self.activation_token = SecureRandom::urlsafe_base64(16)
  end

end
