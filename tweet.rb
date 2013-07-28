require 'csv'
require 'time'

class Tweet < ActiveRecord::Base
  belongs_to :utilisateur

  def date
    created_at.strftime("%B %d %Y %H:%M:%S")
  end

  default_scope order('created_at DESC')
end
