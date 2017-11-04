class WorkersWorkingInBlock < ApplicationRecord
  self.primary_keys = :worker_id, :block_id
  belongs_to :custody_worker, foreign_key: "worker_id"
  belongs_to :block
end
