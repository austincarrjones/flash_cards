require './lib/card'
require './lib/turn'
require './lib/deck'
require './lib/round'
require "pry"

RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe Round do

  it 'exists' do
    #this is called setup (before line break)
    card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
    card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
    cards = [card_1, card_2, card_3]
    deck = Deck.new(cards)
    round = Round.new(deck)

    expect(round).to be_instance_of(Round)
    expect(round.deck).to eq(deck)
    expect(round.turns).to eq([])
    expect(round.current_card).to eq(card_1)
  end

  it 'can take turns' do
    card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
    card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
    cards = [card_1, card_2, card_3]
    deck = Deck.new(cards)
    round = Round.new(deck)
    new_turn = round.take_turn("Juneau")

    expect(new_turn.class).to eq(Turn)
    expect(new_turn.correct?).to eq true
    expect(round.turns).to eq([card_1])
    expect(round.number_correct).to eq(1)
    expect(round.current_card).to eq(card_2)
    round.take_turn("Venus")
    expect(round.turns.count).to eq(2)
    expect(round.turns.last.feedback).to eq("Incorrect.")
    expect(round.number_correct).to eq(1)
    expect(round.current_card).to eq(card_3)
  end

  xit 'can track number correct' do
    card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
    card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
    cards = [card_1, card_2, card_3]
    deck = Deck.new(cards)
    round = Round.new(deck)

    expect(round.number_correct).to eq(0)
    round.take_turn("Juneau")
    expect(round.number_correct).to eq(1)
    round.take_turn("Venus")
    expect(round.number_correct).to eq(1)
  end

  xit 'can track number correct by category' do
    card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
    card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
    cards = [card_1, card_2, card_3]
    deck = Deck.new(cards)
    round = Round.new(deck)

    expect(number_correct_by_category(:Geography)).to eq(0)

    round.take_turn("Juneau")
    round.take_turn("Venus")

    expect(number_correct_by_category(:Geography)).to eq(1)
    expect(round.number_correct_by_category(:STEM)).to eq(0)
  end
  
  xit 'can calculate percent correct' do
    card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
    card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
    cards = [card_1, card_2, card_3]
    deck = Deck.new(cards)
    round = Round.new(deck)

    expect(round.percent_correct).to eq(0.0)

    round.take_turn("Juneau")
    round.take_turn("Venus")

    expect(round.percent_correct).to eq(50.0)
  end

  xit 'can calculate percent correct by category' do
    card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
    card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
    cards = [card_1, card_2, card_3]
    deck = Deck.new(cards)
    round = Round.new(deck)

    expect(round.percent_correct_by_category(:Geography)).to eq(0.0)

    round.take_turn("Juneau")
    round.take_turn("Venus")
    
    expect(round.percent_correct_by_category(:Geography)).to eq(100.0)
    expect(round.percent_correct_by_category(:STEM)).to eq(0.0)
  end

end