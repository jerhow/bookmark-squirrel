class Bookmark < ApplicationRecord
  belongs_to :group

  validates_presence_of :title, :url
end
