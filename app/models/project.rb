class Project < ApplicationRecord
  has_one_attached :image
  has_one_attached :audio_file

  validates :project_type, presence: true, inclusion: { in: %w[Film Voice Commercial Clown] }
  validates :title, presence: true
  validates :description, presence: true
  validates :image, attached: true, content_type: ['image/png', 'image/jpeg'], size: { less_than: 10.megabytes, message: 'should be less than 10MB' }
  # validates :link, presence: true, format: { with: URI::regexp(%w[http https]), message: "must be a valid URL" }

  before_save :adjust_video_link

  # Method to get the YouTube or Vimeo thumbnail URL
  def video_thumbnail
    return unless link.present?

    if link.include?("youtube.com") || link.include?("youtu.be") || link.include?("youtube.com/embed")
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
    elsif link.include?("vimeo.com")
      video_id = URI.parse(link).path.split("/").last
      # Use Vimeo's oEmbed API to fetch the thumbnail
      vimeo_thumbnail_url(video_id)
    end
  end

  # Generate the embed link for YouTube or Vimeo
  def embed_video_link
    return unless link.present?

    if link.include?("youtube.com") || link.include?("youtu.be")
      video_id = if link.include?("youtube.com")
                    URI.parse(link).query.split("&").find { |param| param.start_with?("v=") }&.split("=")&.last
                  elsif link.include?("youtu.be")
                    URI.parse(link).path.split("/").last
                  end
      "https://www.youtube.com/embed/#{video_id}" if video_id
    elsif link.include?("vimeo.com")
      video_id = URI.parse(link).path.split("/").last
      "https://player.vimeo.com/video/#{video_id}" if video_id
    end
  end

  private

  # Adjust the video link to an embedded format
  def adjust_video_link
    self.link = embed_video_link if link.present?
  end

  # Fetch the Vimeo thumbnail URL using the oEmbed API
  def vimeo_thumbnail_url(video_id)
    require 'net/http'
    require 'json'

    url = URI("https://vimeo.com/api/oembed.json?url=https://vimeo.com/#{video_id}")
    response = Net::HTTP.get(url)
    json = JSON.parse(response)
    json["thumbnail_url"] # Return the thumbnail URL
  rescue StandardError
    nil # Return nil if there's an error
  end
end
