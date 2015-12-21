_ = require 'underscore'
Card = require('./card').Card

class CardSet

  suits: ['Spades','Clubs','Hearts','Diamonds']
  ranks: ['A','2','3','4','5','6','7','8','9','10','J','Q','K']

  constructor: ->
    @cards = []

  count: ->
    @cards.length

  find: (rank, suit) ->
    _.find(@cards, (card) -> card.rank == rank and card.suit == suit )

  add: (card) ->
    @cards.push card

  shuffle: ->
    @cards = _.shuffle(@cards)


root = exports ? window
root.CardSet = CardSet
