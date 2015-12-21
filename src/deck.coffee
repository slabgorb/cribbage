_ = require 'underscore'
Card = require('./card').Card
CardSet = require('./card_set').CardSet

class Deck extends CardSet


  constructor: ->
    @hands = []
    @discards = new CardSet()
    @crib = new CardSet()
    @cut = null
    super()
    _.each @suits, (suit) =>
      _.each @ranks, (rank) =>
        @cards.push new Card(rank, suit)

  count: ->
    @cards.length

  cutCard: ->
    @cut = _.sample @cards
    @cut

  deal: (hands, count) ->
    _.times count, =>
      _.each hands, (hand) =>
        hand.add @draw()
    hands

  draw: ->
    @cards.shift()




  discard: ->
    discardedCard = @draw()
    @discards.add discardedCard
    discardedCard

root = exports ? window
root.Deck = Deck
