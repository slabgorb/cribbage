CardSet = require('./card_set').CardSet
class Card
  suits: ['Clubs','Diamonds','Hearts','Spades']
  ranks: ['A','2','3','4','5','6','7','8','9','10','J','Q','K']

  constructor: (rank, suit) ->
    @rank = rank
    @suit = suit

  @sort: (cardA, cardB) ->
    switch
      when cardA.rank < cardB.rank then -1
      when cardB.rank < cardA.rank then 1
      when cardA.suit < cardB.suit then -1
      when cardB.suit < cardA.suit then 1
      else 0

  rankVal: ->
    @ranks.indexOf(@rank)


  value: ->
    val = ['A','2','3','4','5','6','7','8','9'].indexOf(@rank)
    if val == -1 then 10 else val + 1



root = exports ? window
root.Card = Card
