class ListLog < ApplicationRecord
  belongs_to :list
  belongs_to :tweet
end
