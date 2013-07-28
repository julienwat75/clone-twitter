require 'csv'
require 'time'

class Tweet
  attr_accessor :date_complete, :contenu, :pseudo

  def initialize(contenu, pseudo, date_complete = Time.now)
    @date_complete = date_complete
    @contenu = contenu
    @pseudo = pseudo
  end

  def self.publier(contenu, pseudo, date_complete = Time.now)
    tweet = new(contenu, pseudo, date_complete)
    CSV.open("./tweets.csv", "ab") do |csv|
      csv << [tweet.contenu, tweet.date_complete, tweet.pseudo]
    end
    tweet
  end

  def date
    @date_complete.strftime("%B %d %Y %H:%M:%S")
  end

  def self.depuis_csv
    binding.pry
    tweets = []
    CSV.foreach("./tweets.csv") do |ligne|
      contenu = ligne[0]
      date_complete = Time.parse(ligne[1])
      pseudo = ligne[2]
      tweets << Tweet.new(contenu, pseudo, date_complete)
    end
    tweets.sort_by { |tweet| tweet.date_complete }.reverse
  end
end
