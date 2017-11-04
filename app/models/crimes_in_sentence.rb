class CrimesInSentence < ApplicationRecord
  self.primary_keys = :sentence_id, :crime_type
  belongs_to :sentence
end
