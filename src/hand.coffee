_ = require 'underscore'
Card = require('./card').Card
CardSet = require('./card_set').CardSet

class Hand extends CardSet

  constructor: (deck) ->
    @deck = deck
    @crib = []
    super()

  discard: (card) ->
    if typeof card is 'number'
      card = @cards[card]
    if typeof card is 'object' and card.length == 2
      card = @find(card[0], card[1])
    @deck.discards.push card
    @cards = _.reject(@cards, (c) -> c == card)


root = exports ? window
root.Hand = Hand
