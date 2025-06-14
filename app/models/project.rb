class Project < ApplicationRecord
  has_one_attached :image
  has_one_attached :audio_file

  validates :project_type, presence: true, inclusion: { in: %w[Film Voice Commercial Clown] }
  validates :title, presence: true
  validates :description, presence: true
  # validates :link, presence: true, format: { with: URI::regexp(%w[http https]), message: "must be a valid URL" }

  before_save :adjust_youtube_link

  # Method to get the YouTube thumbnail URL
  def youtube_thumbnail
    return unless link.present? && (link.include?("youtube.com") || link.include?("youtu.be") || link.include?("youtube.com/embed"))

    video_id = if link.include?("youtube.com") && link.include?("v=")
                 # Handle normal YouTube link with query parameters
                 URI.parse(link).query&.split("&")&.find { |param| param.start_with?("v=") }&.split("=")&.last
               elsif link.include?("youtu.be")
                 # Handle shortened YouTube link
                 URI.parse(link).path.split("/").last
               elsif link.include?("youtube.com/embed")
                 # Handle embed YouTube link
                 URI.parse(link).path.split("/").last
               end

    "https://img.youtube.com/vi/#{video_id}/hqdefault.jpg" if video_id
  end

  # Method to adjust the YouTube link to an embedded format
  def embed_youtube_link
    return unless link.present? && (link.include?("youtube.com") || link.include?("youtu.be"))

    video_id = if link.include?("youtube.com")
                 URI.parse(link).query.split("&").find { |param| param.start_with?("v=") }&.split("=")&.last
               elsif link.include?("youtu.be")
                 URI.parse(link).path.split("/").last
               end

    "https://www.youtube.com/embed/#{video_id}?si=YB5XLc3XYuDuJOvy" if video_id
  end

  private

  def adjust_youtube_link
    self.link = embed_youtube_link if link.present?
  end
end
