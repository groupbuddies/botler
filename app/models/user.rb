class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  has_many :expenses

  validates :name, :email, presence: true
  validates :email, uniqueness: true, format: { with: /\A\s*([-a-z0-9+._]{1,64})@((?:[-a-z0-9]+\.)+[a-z]{2,})\s*\z/i }
end
