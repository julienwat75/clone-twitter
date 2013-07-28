class Utilisateur < ActiveRecord::Base
  has_many :tweets

  has_many :relations
  has_many :suivis, :through => :relations
end
