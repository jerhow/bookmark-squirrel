class User < ApplicationRecord
    has_and_belongs_to_many :groups
    
    validates_presence_of :name, :email
end
