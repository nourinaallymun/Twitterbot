#!/usr/bin/env ruby

require 'Twitter'

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "kVGPHiPyzus4obWSRaG8mnYdy"
  config.consumer_secret     = "nPba5PBnT8vi9nLpMWR7zxBsd7hamjhupL1gFXxbpBaWPwePrf"
  config.access_token        = "934359443667636224-ftTiowgQm1va10XDe52iDKk6dkY5FJp"
  config.access_token_secret = "xcBIpac2QdXTp6USMLZhiCSmXOVUoNZ3e1Di6yqBTREtQ"
end

search_options = {
  result_type: "recent",
}

client.search("chaussures", search_options).take(100).each do |tweet|
  puts "#{tweet.user.screen_name}: #{tweet.text}"
  client.favorite(tweet)
  client.update_with_media("@#{tweet.user.screen_name} Commandez vos chaussures sur Sarenza.com et bénéficiez d'une réduction de 20€ dès 100€ d'achat. Remplissez vite votre panier sur  http://www.sarenza.com !!", File.new("sarenza.png"))
  users = []
  users.push(tweet.user.id)
  puts tweet
  client.follow(users)
  sleep 40
end


follower_ids = client.follower_ids('chaussures')
begin
follower_ids.to_a
rescue Twitter::Error::TooManyRequests => error
sleep error.rate_limit.reset_in + 1
retry
end
