class Round

  attr_reader :deck,
              :turns,
              :current_card,
              :number_correct

	def initialize(deck)
		@deck = deck
    @turns = []
    @current_card = deck.cards[turns.length]
    @number_correct = 0
	end

  def take_turn(guess)
    @turns << @current_card
    turn = Turn.new(guess,@current_card)
    if turn.correct?
      @number_correct += 1
    end
    turn
  end
    
#the amount of turns taken = the turns.length (length of array)
#the current card should be the last element of @turns
end