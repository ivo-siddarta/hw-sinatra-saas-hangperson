class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor:word
  attr_accessor:guesses
  attr_accessor:wrong_guesses
  attr_accessor:word_with_guesses
  attr_accessor:attempt

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @word_with_guesses = ''
    for i in 1..@word.length
      @word_with_guesses += '-'
    end
    @attempt = 7
  end

  def guess(char_input)
    if char_input.eql?('') || char_input == nil  || !/[A-Za-z]/.match(char_input)
      raise ArgumentError, "Argument Can't Be Empty or non-alphabetical"
    end
    if @guesses.include?(char_input.downcase) || @wrong_guesses.include?(char_input.downcase)
      return false
    end

    if @word.include?(char_input)
      @guesses += char_input
      @word.chars.zip(0..(@word.length - 1)) do |character,index|
        if @word_with_guesses[index].eql?('-') && char_input.eql?(character)
          @word_with_guesses[index] = char_input
        end
      end
    else
      @wrong_guesses += char_input
      @attempt -= 1
    end
    return true
  end

  def check_win_or_lose()
    if not @word_with_guesses.include?('-')
      return :win
    elsif @attempt <= 0
      return :lose
    else
      return :play
    end
  end
  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
