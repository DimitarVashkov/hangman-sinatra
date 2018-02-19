class Word
  attr_reader :guess, :letters_used, :turn
  def initialize
    @turn = 1
    @word = random_word_from(read_dictionary).split('')
    @guess = create_guess_holder(@word)
    @letters_used = []
  end

  def take_letter(letter)
    letter = letter.to_s
    if @letters_used.include?(letter) || letter.nil?
      nil
    elsif @word.include?(letter)
      @letters_used << letter
      change_guess(letter)
    else
      if letter.size == 1
        @letters_used << letter
        @turn += 1
      end
      nil
    end
  end

  def turn?
    @turn
  end

  def change_guess(letter)
    @word.each_with_index do |val, i|
      @guess[i] = letter if letter == val
    end
  end


  def read_dictionary
    dictionary = []
    begin
      File.readlines('dict.txt').each do |line|
        line.chomp!
        dictionary << line if line.size > 5 && line.size < 13
      end
    rescue IOError => exception
      puts exception.message
      puts exception.backtrace
      puts "Couldn't read dict.txt file"
    end
    dictionary
  end

  def random_word_from(dictionary)
    dictionary.sample
  end

  def create_guess_holder(word)
    guess = []
    word.length.times do
      guess << '_'
    end
    guess
  end

  def won?(guess, word)
    guess == word
  end


end