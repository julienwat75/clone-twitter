class CreerRelations < ActiveRecord::Migration
  def up
    create_table "relations" do |t|
      t.integer   "utilisateur_id"
      t.integer   "suivi_id"
      t.timestamps
    end
  end
end
