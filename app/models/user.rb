class User < ApplicationRecord
  has_secure_password
  # mount_uploader :avatar, AvatarUploader
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, uniqueness: true
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }            
  after_create :confirm_email   
  before_create :generate_confirmation_instructions
  # has_and_belongs_to_many :conversations, dependent: :destroy
  has_one_attached :image
  
  def confirm_email
    UserMailer.confirm_email(self).deliver_now
  end         


  def generate_confirmation_instructions
    self.confirmation_token = SecureRandom.hex(10)
    self.confirmation_sent_at = Time.now.utc
  end


  def confirmation_token_valid?
    (self.confirmation_sent_at + 30.days) > Time.now.utc
  end

  def mark_as_confirmed!
    self.confirmation_token = nil
    self.is_confirm = true
    save
  end

  def confirmed_at?
    self.is_confirm == true
  end

  def send_reset_password_link
    self.reset_password_token = SecureRandom.hex(10)
    save
  end  
end




