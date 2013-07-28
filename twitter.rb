# encoding: utf-8

require "pry"

require "sinatra"

get "/" do
  binding.pry
  "Qui êtes-vous ?

   <form>
     <input type='text' name='pseudo'>
   </form>"
end
