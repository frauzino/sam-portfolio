class Event < ApplicationRecord
  has_one_attached :image
  validates :title, presence: true
  validates :date, presence: true
end
