class WelcomeController < ApplicationController
  
  def index 
    @favorite_books = ["Harry Potter", "Game of Thrones", "Lord of the Rings"]
  end

end
