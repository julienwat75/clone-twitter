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

   <form action='/connexion'>
     <input type='text' name='pseudo'>
   </form>"
end

get "/connexion" do
  pseudo = params["pseudo"]
  cookies["pseudo"] = pseudo
  redirect '/'
end
