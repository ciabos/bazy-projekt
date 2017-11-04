class ResourcesAssignedToPrisoner < ApplicationRecord
  self.primary_keys = :prisoner_id, :resource_id
  belongs_to :resource
  belongs_to :prisoner
end
