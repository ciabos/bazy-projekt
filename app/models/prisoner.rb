class Prisoner < ApplicationRecord
  has_many :passes
  has_many :sentences
  has_many :resources_assigned_to_prisoner
  has_many :resources, through: :resources_assigned_to_prisoner
  has_many :prisoners_in_incidents
  has_many :incidents, through: :prisoners_in_incidents
end
