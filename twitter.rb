# encoding: utf-8

require "pry"

require "sinatra"
require "sinatra/cookies"

get "/" do
  if cookies["pseudo"]
    pseudo = cookies["pseudo"]
    "Bienvenue sur Twitter #{pseudo}
    <br>
    <a href='/deconnexion'>déconnexion</a>"
  else
    redirect '/formulaire_de_connexion'
  end
end

get "/formulaire_de_connexion" do
  "Qui êtes-vous ?

  <form action='/connexion'>
    <input type='text' name='pseudo'>
  </form>"
end

get "/connexion" do
  pseudo = params["pseudo"]
  cookies["pseudo"] = pseudo
  redirect '/'
end

get '/deconnexion' do
  cookies.clear
  redirect '/'
end
