class Card
  constructor: (rank, suit) ->
    @rank = rank
    @suit = suit

  value: ->
    val = ['A','2','3','4','5','6','7','8','9'].indexOf(@rank)
    if val == -1 then 10 else val + 1


root = exports ? window
root.Card = Card
