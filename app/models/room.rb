class Room < ApplicationRecord
  validates_uniqueness_of :name
  scope :public_room, -> { where(is_private: false) }
  after_create_commit { broadcast_append_to 'rooms' }
end
