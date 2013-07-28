# encoding: utf-8

# ----------------------------
# ce dont notre appli à besoin
# ----------------------------

require "pry"

require "sinatra"

require "sinatra/activerecord"

configure :development do
  set :database, "sqlite3:///twitter.sqlite3"
end

configure :production do
  set :database, ENV["DATABASE_URL"]
end

require "./tweet.rb"
require "./utilisateur.rb"
require "./relation.rb"

enable :sessions

# ------------------------------------------
# récupérer l'utilisateur courant facilement
# ------------------------------------------

def utilisateur_courant
  pseudo = session["pseudo"]
  Utilisateur.find_by_pseudo(pseudo) if pseudo
end

# --------------
# page d'acceuil
# --------------

get "/" do
  if utilisateur_courant
    @tweets = []
    utilisateur_courant.suivis.each do |utilisateur_suivi|
       @tweets += utilisateur_suivi.tweets
    end

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

  tweet = Tweet.create(contenu: contenu)
  utilisateur_courant.tweets << tweet

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

# ----------
# mon profil
# ----------

get "/utilisateurs/:pseudo" do
  pseudo = params["pseudo"]
  @utilisateur = Utilisateur.find_by_pseudo(pseudo)
  erb :profil_utilisateur
end

# ----------------------
# liste des utilisateurs
# ----------------------

get "/utilisateurs" do
  @utilisateurs = Utilisateur.all
  erb :utilisateurs
end

# -----------------------------------------
# suivre - arrêter de suivre un utilisateur
# -----------------------------------------

post "/suivre" do
  pseudo_suivi = params["pseudo"]
  suivi = Utilisateur.find_by_pseudo(pseudo_suivi)

  utilisateur_courant.suivis << suivi

  redirect '/'
end

post "/arreter-de-suivre" do
  pseudo_suivi = params["pseudo"]
  suivi = Utilisateur.find_by_pseudo(pseudo_suivi)

  utilisateur_courant.suivis.delete(suivi)

  redirect '/'
end
