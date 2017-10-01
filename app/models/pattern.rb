class Pattern < ApplicationRecord
  scope :active, -> { where(active: true) }
  scope :random, -> { order("RANDOM()") }
end
