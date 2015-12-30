_ = require 'underscore'
Card = require('./card').Card
CardSet = require('./card_set').CardSet

class PeggingStack extends CardSet

  countPairs: (cards) ->
    cards ?= @cards
    # look at the last card played, then go through the stack in
    # reverse order to see how many match it
    cards = cards.reverse()

    compareCard = _.first(cards)
    restOfStack = _.rest(cards)
    matches = [compareCard]
    notDone = true
    _.each restOfStack, (card) ->
      if card.rank == compareCard.rank and notDone
        matches.push(card)
      else
        notDone = false
    super(matches)

  countRuns: (cards) ->


  countFifteens: (cards) ->
    cards ?= @cards
    if _.reduce(cards, ((memo, card) -> memo += card.value()), 0) == 15 then 2 else 0

  countThirtyOnes: (cards) ->
    cards ?= @cards
    if _.reduce(cards, ((memo, card) -> memo += card.value()), 0) == 31 then 2 else 0

root = exports ? window
root.PeggingStack = PeggingStack
