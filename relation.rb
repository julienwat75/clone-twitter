class Relation < ActiveRecord::Base
  belongs_to :utilisateur
  belongs_to :suivi, :class_name => 'Utilisateur'
end
