class Pass < ApplicationRecord
  self.primary_keys = :prisoner_id, :release_date
  belongs_to :prisoner
end
