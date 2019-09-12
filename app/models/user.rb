class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :recoverable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable, :trackable
  has_and_belongs_to_many :groups
  has_one_attached :avatar

  validates_presence_of :name, :email

  after_initialize :set_defaults

  def set_defaults
    self.profile_image ||= "bs-default-avatar-01.png"
  end

  def get_groups
    self.groups.order(title: :asc)
  end
end
