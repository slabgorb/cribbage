class Card
  constructor: (rank, suit) ->
    @rank = rank
    @suit = suit

root = exports ? window
root.Card = Card
