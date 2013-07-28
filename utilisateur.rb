class Utilisateur
  attr_accessor :pseudo, :mot_de_passe

  def initialize(pseudo, mot_de_passe)
    @pseudo = pseudo
    @mot_de_passe = mot_de_passe
  end

  def self.creer(pseudo, mot_de_passe)
    utilisateur = new(pseudo, mot_de_passe)
    CSV.open("./utilisateurs.csv", "ab") do |csv|
      csv << [utilisateur.pseudo, utilisateur.mot_de_passe]
    end
    utilisateur
  end

  def self.depuis_csv
    utilisateurs = []
    CSV.foreach("./utilisateurs.csv") do |ligne|
      pseudo = ligne[0]
      mot_de_passe = ligne[1]
      utilisateurs << Utilisateur.new(pseudo, mot_de_passe)
    end
    utilisateurs
  end

  def self.trouver_par_pseudo(pseudo)
    utilisateurs = depuis_csv
    utilisateurs.detect { |utilisateur| utilisateur.pseudo == pseudo }
  end
end
