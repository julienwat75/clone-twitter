class CreerUtilisateurs < ActiveRecord::Migration
  def up
    create_table "utilisateurs" do |t|
      t.string   "pseudo", :null => false, :unique => true
      t.string   "mot_de_passe", :null => false
      t.timestamps
    end
  end
end
