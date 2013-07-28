# encoding: utf-8

require "./tweet.rb"

puts "Qui êtes-vous ?"
pseudo = gets.strip
puts "Bienvenue sur Twitter, #{pseudo} !"
puts "Quoi de neuf ?"
contenu = gets.strip
nouveau_tweet = Tweet.publier(contenu, pseudo)
puts "#{nouveau_tweet.pseudo} : #{nouveau_tweet.contenu} le #{nouveau_tweet.date}"
