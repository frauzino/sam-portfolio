json.extract! event, :id, :title, :data, :link, :created_at, :updated_at
json.url event_url(event, format: :json)
