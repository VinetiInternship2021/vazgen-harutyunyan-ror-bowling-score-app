class Session < ApplicationRecord
    validates :players_count, presence: true, inclusion: 1..8
end
