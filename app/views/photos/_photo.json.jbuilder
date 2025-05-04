json.extract! photo, :id, :title, :description, :photo_type, :link, :created_at, :updated_at
json.url photo_url(photo, format: :json)
