# encoding: utf-8

require "pry"

require "sinatra"

get "/" do
  "Qui êtes-vous ?

   <form action='/bienvenue'>
     <input type='text' name='pseudo'>
   </form>"
end

get "/bienvenue" do
  binding.pry
  pseudo = params["pseudo"]
  "Bienvenue sur Twitter, #{pseudo} !

   Revenir à l'<a href='/'>accueil</a>"
end
