class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_and_belongs_to_many :groups

  validates_presence_of :name, :email

  after_initialize :set_defaults

  def set_defaults
    self.profile_image ||= Placeholder.image_generator(width: '150', height: '150')
  end
end
