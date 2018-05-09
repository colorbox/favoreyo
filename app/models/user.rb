class User < ApplicationRecord
  has_many :timeline_logs, dependent: :destroy
  has_many :tweets, through: :timeline_logs
end
