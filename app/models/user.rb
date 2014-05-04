class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  before_save :phone
  before_create :create_remember_token
  validates :name,  presence: true, length: { maximum: 50 }, if: :name
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, if: :email,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }, if: :password
  #validates :grade, presence: true
  validates :phone, presence: true, length: { is: 10 }, if: :phone
  belongs_to :roster
  has_many :rosters, dependent: :destroy #as: :teacher #:klass, class_name: "Roster"
  
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end
  
  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  def phone=(phone)
    write_attribute(:phone, phone.gsub(/\D/, ''))
  end
  
  private
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

end
