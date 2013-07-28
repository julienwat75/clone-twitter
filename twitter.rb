# encoding: utf-8

# ----------------------------
# ce dont notre appli à besoin
# ----------------------------

require "pry"

require "sinatra"
require "sinatra/cookies"

require "./tweet.rb"
require "./utilisateur.rb"

# --------------
# page d'acceuil
# --------------

get "/" do
  if cookies["pseudo"]
    @pseudo = cookies["pseudo"]
    @tweets = Tweet.depuis_csv

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

  utilisateur = Utilisateur.trouver_par_pseudo(pseudo)

  if utilisateur and utilisateur.mot_de_passe == mot_de_passe
    cookies["pseudo"] = pseudo
    redirect '/formulaire_de_tweet'
  else
    redirect '/formulaire_de_connexion'
  end
end

post "/deconnexion" do
  cookies.clear
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
  pseudo = cookies["pseudo"]
  Tweet.publier(contenu, pseudo)
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
  Utilisateur.creer(pseudo, mot_de_passe)
  redirect '/'
end
