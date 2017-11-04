class PrisonersInIncident < ApplicationRecord
  self.primary_keys = :incident_id, :prisoner_id

  belongs_to :incident
  belongs_to :prisoner
end
