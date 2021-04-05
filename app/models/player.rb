class Player < ApplicationRecord
  belongs_to :session
  has_many :frames
  validates_inclusion_of :score, in: 0..300
end
