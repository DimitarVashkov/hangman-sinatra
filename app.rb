require_relative 'word'
require 'sinatra'

new_game = Word.new

get '/' do
  letter = params["letter"]
  turn = new_game.turn?
  new_game.take_letter(letter) unless new_game.nil?
  letters_used = new_game.letters_used.join(' ')
  guess = new_game.guess.join(' ')
  if turn == 8
    new_game = nil
  end
  erb :index, locals: {turn: turn, guess: guess, letters_used: letters_used}
end

get '/POST' do
  new_game = Word.new
  redirect '/'
end