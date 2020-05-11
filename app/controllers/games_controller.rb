require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(8)
  end

  def score
    @letters = params[:letters].split(//)
    @word = (params[:word] || "").upcase
    @included = included?(@letters, @word)
    @english_word = english_word?(@word)
  end

  private

  def included?(letters, word)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
