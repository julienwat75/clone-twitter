# encoding: utf-8

# ----------------------------
# ce dont notre appli à besoin
# ----------------------------

require "pry"

require "sinatra"

require "sinatra/activerecord"
set :database, "sqlite3:///twitter.sqlite3"

require "./tweet.rb"
require "./utilisateur.rb"

enable :sessions

# --------------
# page d'acceuil
# --------------

get "/" do
  if session["pseudo"]
    @pseudo = session["pseudo"]
    @tweets = Tweet.all

    erb :page_accueil
  else
    redirect '/formulaire_de_connexion'
  end
end

# -----------------------
# connexion - déconnexion
# -----------------------

get "/formulaire_de_connexion" do
  erb :formulaire_de_connexion
end

post "/connexion" do
  pseudo = params["pseudo"]
  mot_de_passe = params["mot_de_passe"]

  utilisateur = Utilisateur.find_by_pseudo(pseudo)

  if utilisateur and utilisateur.mot_de_passe == mot_de_passe
    session["pseudo"] = pseudo
    redirect '/formulaire_de_tweet'
  else
    redirect '/formulaire_de_connexion'
  end
end

post "/deconnexion" do
  session.clear
  redirect '/'
end

# ----------------
# publier un tweet
# ----------------

get "/formulaire_de_tweet" do
  erb :formulaire_de_tweet
end

post "/publier_un_tweet" do
  contenu = params["contenu"]
  pseudo = session["pseudo"]

  tweet = Tweet.create(contenu: contenu)
  utilisateur = Utilisateur.find_by_pseudo(pseudo)
  utilisateur.tweets << tweet

  redirect '/'
end

# ---------------
# créer un compte
# ---------------

get "/formulaire_de_creation_de_compte" do
  erb :formulaire_de_creation_de_compte
end

post "/creer_compte" do
  pseudo = params["pseudo"]
  mot_de_passe = params["mot_de_passe"]

  Utilisateur.create(pseudo: pseudo, mot_de_passe: mot_de_passe)

  redirect '/'
end
