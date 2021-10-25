class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  attr_accessor :word_with_guesses
  attr_accessor :word_length
  attr_accessor :check_win_or_lose
  attr_accessor :count
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @word_with_guesses = '-'* word.length
    @word_length = word.length
    @check_win_or_lose = :play
    @count = 0
  end

  def guess(guess_word)
    if guess_word == '' or (guess_word.nil?) or not (guess_word =~ /[A-Za-z]/)
      raise ArgumentError
    end
    @count = self.count + 1
    if (self.word.include? guess_word.downcase) and not (self.guesses.include? guess_word.downcase)
      @guesses = self.guesses+guess_word.downcase
      # for i in (0..self.word.length)
      #   if self.guesses.include? self.word[i]
      #     @word_with_guesses[i] = self.word[i]
      #   end
      # end
      for i in 0..(self.word_length-1)
        if self.guesses.include? self.word[i]
          @word_with_guesses[i] = self.word[i]
        end
      end
      if self.count >= self.word_length
        if self.word_with_guesses == self.word
          @check_win_or_lose =:win
        else
          @check_win_or_lose =:lose
        end
      end
      return TRUE

    elsif not(self.word.include? guess_word.downcase) and not (self.wrong_guesses.include? guess_word.downcase)
      @wrong_guesses = self.wrong_guesses+guess_word.downcase
      if self.count >= self.word_length
        if self.word_with_guesses == self.word
          @check_win_or_lose =:win
        else
          @check_win_or_lose =:lose
        end
      end
      return TRUE
    end


    return FALSE
  end


  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end
