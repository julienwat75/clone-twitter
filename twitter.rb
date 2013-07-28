# encoding: utf-8

require "pry"

require "sinatra"
require "sinatra/cookies"

require "./tweet.rb"

get "/" do
  if cookies["pseudo"]
    pseudo = cookies["pseudo"]
    tweets = Tweet.depuis_csv

    tweets_html = ""
    tweets.each do |tweet|
      tweets_html += "<li>#{tweet.contenu} à #{tweet.date} par #{tweet.pseudo}</li>"
    end

    "Bienvenue sur Twitter #{pseudo}
    <br>
    <form action='/deconnexion' method='post'>
      <input type='submit' value='deconnexion'>
    </form>
    <br>
    Souhaitez-vous <a href='/formulaire_de_tweet'>tweeter</a> ?
    <ul>
       #{tweets_html}
    </ul>"
  else
    redirect '/formulaire_de_connexion'
  end
end

get "/formulaire_de_connexion" do
  "Qui êtes-vous ?

  <form action='/connexion' method='post'>
    <input type='text' name='pseudo'>
  </form>"
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
  "Quoi de neuf ?

  <form action='/publier_un_tweet' method='post'>
    <input type='text' name='contenu'>
  </form>"
end

post "/publier_un_tweet" do
  contenu = params["contenu"]
  pseudo = cookies["pseudo"]
  Tweet.publier(contenu, pseudo)
  redirect '/'
end
