CardSet = require('./card_set.coffee').CardSet
fs = require 'fs'

class Card
  suits: ['Clubs','Diamonds','Hearts','Spades']
  ranks: ['A','2','3','4','5','6','7','8','9','10','J','Q','K']

  constructor: (rank, suit) ->
    @rank = rank
    @suit = suit

  @sort: (cardA, cardB) ->
    cardA.rankVal() - cardB.rankVal()

  rankVal: ->
    @ranks.indexOf(@rank) + 1


  value: ->
    val = ['A','2','3','4','5','6','7','8','9'].indexOf(@rank)
    if val == -1 then 10 else val + 1


  display: ->



root = exports ? window
root.Card = Card
