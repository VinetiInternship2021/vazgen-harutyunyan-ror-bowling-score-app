json.extract! session, :id, :players_count, :created_at, :updated_at
json.url session_url(session, format: :json)
