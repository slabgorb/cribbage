_ = require 'underscore'
Card = require('./card').Card
CardSet = require('./card_set').CardSet

class Hand extends CardSet

  constructor: (deck) ->
    @deck = deck
    @crib = new CardSet()
    super()

  toCrib: (card) ->
    @crib.add(card)

  discard: (card...) ->
    card = @find(card...)
    @deck.discards.push card
    @cards = _.reject(@cards, (c) -> c == card)
    card


root = exports ? window
root.Hand = Hand
