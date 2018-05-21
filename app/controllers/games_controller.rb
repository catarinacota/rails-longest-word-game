require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word]
    @letters = params[:letters]

    if included?(@letters, @word)
      if english_word?(@word)
        @answer = "Congratulations! #{@word} is a valid English word!"
      else
        @answer = "Sorry but #{@word} does not seem to be a valid English word..."
      end
    else
      @answer = "Sorry but the #{@word} can't be built out of #{@letters.chars.join(", ")}"
    end

  end


  def included?(letters, word)
    word.count(letters) == word.length
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end

end
