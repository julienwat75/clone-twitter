# encoding: utf-8

require "pry"

require "./tweet.rb"
require "rainbow"

puts "Qui êtes-vous ?"
pseudo = gets.strip
puts "Bienvenue sur Twitter, #{pseudo} !"
puts "Quoi de neuf ?"
contenu = gets.strip
nouveau_tweet = Tweet.publier(contenu, pseudo)
puts "#{nouveau_tweet.pseudo} : #{nouveau_tweet.contenu} le #{nouveau_tweet.date}"

puts "

================================================================================
                             Bienvenue sur Twitter
================================================================================

"
tweets = Tweet.depuis_csv

tweets.each do |tweet|
  puts "#{tweet.contenu} à #{tweet.date.foreground(:yellow)} par #{tweet.pseudo.background(:blue).foreground(:white)}"
  puts "-" * 80
end
