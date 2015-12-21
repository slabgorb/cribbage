_ = require 'underscore'
Card = require('./card').Card
CardSet = require('./card_set').CardSet

class Deck extends CardSet


  constructor: ->
    @hands = []
    @discards = []
    super()
    _.each @suits, (suit) =>
      _.each @ranks, (rank) =>
        @cards.push new Card(rank, suit)

  count: ->
    @cards.length

  cut: ->
    _.sample @cards

  deal: (hands, count) ->
    _.times count, =>
      _.each hands, (hand) =>
        hand.add @draw()
    hands

  draw: ->
    @cards.shift()




  discard: ->
    discardedCard = @draw()
    @discards.push discardedCard
    discardedCard

root = exports ? window
root.Deck = Deck
