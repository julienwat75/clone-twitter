# encoding: utf-8

require "pry"

require "sinatra"
require "sinatra/cookies"

get "/" do
  if cookies["pseudo"]
    pseudo = cookies["pseudo"]
    salutation = "Bienvenue sur Twitter #{pseudo}"
  else
    salutation= "Qui êtes-vous ?"
  end
  "#{salutation}

   <form action='/bienvenue'>
     <input type='text' name='pseudo'>
   </form>"
end

get "/bienvenue" do
  pseudo = params["pseudo"]
  cookies["pseudo"] = pseudo
  "Bienvenue sur Twitter, #{pseudo} !

   Revenir à l'<a href='/'>accueil</a>"
end
