class Quarter < ApplicationRecord
  self.primary_keys = :prisoner_id, :cell_id, :block_id, :check_in_date

  belongs_to :cell
  belongs_to :block
  belongs_to :prisoner
end
