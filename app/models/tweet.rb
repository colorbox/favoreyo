class Tweet < ApplicationRecord
  def embed_html
    url = "https://api.twitter.com/1/statuses/oembed.json?id=#{tweet_id}"
    result = Net::HTTP.get(URI.parse(url))
    json   = JSON.parser.new(result)
    hash   = json.parse()
    hash['html']
  end
end
