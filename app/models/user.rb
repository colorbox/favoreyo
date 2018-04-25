class User < ApplicationRecord
  has_many :timeline_logs
  has_many :tweet, through: :timeline_logs

end
