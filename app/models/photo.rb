class Photo < ApplicationRecord
  has_one_attached :image
  validates :image, attached: true, content_type: ['image/png', 'image/jpeg'], size: { less_than: 10.megabytes, message: 'should be less than 10MB' }
  validates :orientation, presence: true, inclusion: { in: %w[portrait landscape], message: "%{value} is not a valid orientation" }
end
