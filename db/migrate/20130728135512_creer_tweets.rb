class CreerTweets < ActiveRecord::Migration
  def up
    create_table "tweets" do |t|
      t.string   "contenu", :null => false
      t.integer  "utilisateur_id"
      t.timestamps
    end
  end
end
