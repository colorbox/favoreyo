class List < ApplicationRecord
  has_many :list_logs, dependent: :destroy
  has_many :tweets, through: :list_logs
end
