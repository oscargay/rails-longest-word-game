require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = (1..10).map { ('A'..'Z').to_a[rand(26)] }
  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    @url_serialized = open(url).read
    @word_check = JSON.parse(@url_serialized)
    @letters_array = params[:original_letters].downcase.split(' ')
    @user_array = params[:word].downcase.split('')
    i = 0
    @user_array.each do |letter|
      if @letters_array.include? letter
        @letters_array.delete_at(@letters_array.index(letter))
      else
        i += 1
      end
    end
    if @word_check['found'] == false
      @message = "#{params[:word].capitalize} is not an English word!"
    elsif i >= 1
      @message = "#{params[:word].capitalize} cannot be made from #{params[:original_letters]}"
    else
      @message = "Congratulations, #{params[:word]} is a valid English word!"
    end
  end
end
