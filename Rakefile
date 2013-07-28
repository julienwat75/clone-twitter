# encoding: utf-8

require "sinatra/activerecord/rake"
require "./twitter.rb"

namespace :db do
  desc "Importer les données depuis les CSVs existants"
  task(:importer_depuis_csv) do
    CSV.foreach("./utilisateurs.csv") do |ligne|
      pseudo = ligne[0]
      mot_de_passe = ligne[1]

      Utilisateur.create(pseudo: pseudo, mot_de_passe: mot_de_passe)
    end

    CSV.foreach("./tweets.csv") do |ligne|
      contenu = ligne[0]
      created_at = Time.parse(ligne[1])
      pseudo = ligne[2]

      tweet = Tweet.create(contenu: contenu, created_at: created_at)
      utilisateur = Utilisateur.find_by_pseudo(pseudo)
      binding.pry
      utilisateur.tweets << tweet
    end
  end
end
