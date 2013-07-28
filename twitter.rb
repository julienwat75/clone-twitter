# encoding: utf-8

require "pry"

require "sinatra"
require "sinatra/cookies"

require "./tweet.rb"

get "/" do
  if cookies["pseudo"]
    @pseudo = cookies["pseudo"]
    @tweets = Tweet.depuis_csv

    erb :page_accueil
  else
    redirect '/formulaire_de_connexion'
  end
end

get "/formulaire_de_connexion" do
  erb :formulaire_de_connexion
end

post "/connexion" do
  pseudo = params["pseudo"]
  cookies["pseudo"] = pseudo
  redirect '/'
end

post "/deconnexion" do
  cookies.clear
  redirect '/'
end

get "/formulaire_de_tweet" do
  erb :formulaire_de_tweet
end

post "/publier_un_tweet" do
  contenu = params["contenu"]
  pseudo = cookies["pseudo"]
  Tweet.publier(contenu, pseudo)
  redirect '/'
end
