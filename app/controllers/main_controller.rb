class MainController < ApplicationController 
  def hello 
  end

  def hi
  end

  def greetings 
    @name = params[:name]
  end 

end