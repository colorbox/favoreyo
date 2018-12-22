class List < ApplicationRecord
  has_many :list_logs, dependent: :destroy
end
