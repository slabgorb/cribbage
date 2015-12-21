_ = require 'underscore'
Card = require('./card').Card


class Deck
  suits: ['Spades','Clubs','Hearts','Diamonds']
  ranks: ['A','2','3','4','5','6','7','8','9','10','J','Q','K']
  constructor: ->
    @discards = []
    @cards = []
    _.each @suits, (suit) =>
      _.each @ranks, (rank) =>
        @cards.push new Card(rank, suit)

  shuffle: ->
    @cards = _.shuffle(@cards)

  discard: ->
    discardedCard = @cards.shift()
    @discards.push discardedCard
    discardedCard

root = exports ? window
root.Deck = Deck
