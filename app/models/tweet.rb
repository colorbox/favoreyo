require 'net/http'
require 'json'

class Tweet < ApplicationRecord
  has_many :timeline_logs, dependent: :destroy

  def embed_html
    url = "https://api.twitter.com/1.1/statuses/oembed.json?id=#{tweet_id}"
    result = Net::HTTP.get(URI.parse(url))
    json = JSON.parser.new(result)
    hash = json.parse()
    hash['html']
  end
end
