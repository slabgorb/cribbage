_ = require 'underscore'
Card = require('./card').Card

class CardSet
  suits: ['Spades','Clubs','Hearts','Diamonds']
  ranks: ['A','2','3','4','5','6','7','8','9','10','J','Q','K']

  constructor: ->
    @cards = []

  count: ->
    @cards.length


  find: (args...) ->
    switch
      when typeof args[0] == 'number' then @cards[args[0]]
      when args.length == 2 and typeof args[0] == 'string'
        rank = args[0]
        suit = args[1]
        _.find(@cards, (card) -> card.rank == rank and card.suit == suit )
      else
        _.find(@cards, (card) -> card == args[0])

  add: (card) ->
    @cards.push card

  remove: (card...) ->
    card = @find(card...)
    @cards = _.reject(@cards, (c) -> c == card)

  shuffle: ->
    @cards = _.shuffle(@cards)


root = exports ? window
root.CardSet = CardSet
