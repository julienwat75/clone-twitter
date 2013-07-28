# encoding: utf-8

require "pry"

require "sinatra"

get "/" do
  "Qui êtes-vous ?

   <form>
     <input type='text' name='pseudo'>
   </form>"
end
