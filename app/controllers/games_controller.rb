require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample }
    @test = 'je suis là'
  end

  def score
    @grid = params[:letters]
    @attempt = params[:word].upcase
    @included = in_grid?(@attempt, @grid)
    @english = english_word?(@attempt)
  end

  private

  def in_grid?(attempt, grid)
    attempt.upcase.chars.all? { |letter| grid.include?(letter) }
  end

  def english_word?(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    attempt_data = JSON.parse(open(url).read)
    attempt_data['found']
  end
end
