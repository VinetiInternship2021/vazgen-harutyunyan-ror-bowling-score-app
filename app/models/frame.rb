class Frame < ApplicationRecord

  validates_inclusion_of :frame, in:1..10
  validates_inclusion_of :knocked_pins, in:0..10
end
