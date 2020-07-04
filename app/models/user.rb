class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthab
  enum role: [:user, :creator]

  has_many :room_users

  has_many :rooms, through: :room_users ,dependent: :destroy

  has_many :room_messages, dependent: :destroy
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  validates :username, uniqueness: true, presence: true
  validates :email,  presence: true, length: { maximum: 50 },uniqueness: true

  
  def name
    email.split('@')[0]
  end

  def gravatar_url
    gravatar_id = Digest::MD5::hexdigest(email).downcase
    "https://gravatar.com/avatar/#{gravatar_id}.png"
  end
end
