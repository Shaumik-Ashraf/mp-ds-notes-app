class Note < ApplicationRecord
  belongs_to :user
  encrypts :body

  validates :body, presence: true
end
