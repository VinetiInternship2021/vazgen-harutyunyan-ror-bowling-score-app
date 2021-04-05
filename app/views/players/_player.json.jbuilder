json.extract! player, :id, :name, :session_id, :score, :session_winner, :created_at, :updated_at
json.url player_url(player, format: :json)
