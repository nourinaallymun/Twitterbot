#!/usr/bin/env ruby

require 'Twitter'

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ""
  config.consumer_secret     = ""
  config.access_token        = ""
  config.access_token_secret = ""
end

search_options = {
  result_type: "recent",
}

client.search("chaussures", search_options).take(100).each do |tweet|
  puts "#{tweet.user.screen_name}: #{tweet.text}"
  client.favorite(tweet)
  client.update_with_media("@#{tweet.user.screen_name} Commandez vos chaussures sur Sarenza.com et bénéficiez d'une réduction de 20€ dès 100€ d'achat. Remplissez vite votre panier sur  http://www.sarenza.com !!", File.new("sarenza.png"))
  sleep 25
  users = []
  users.push(tweet.user.id)
  puts tweet
  client.follow(users)
  sleep 43
end


follower_ids = client.follower_ids('chaussures')
begin
follower_ids.to_a
rescue Twitter::Error::TooManyRequests => error
sleep error.rate_limit.reset_in + 1
retry
end
