_ = require 'underscore'
Card = require('./card').Card
CardSet = require('./card_set').CardSet

class PeggingStack extends CardSet

  countPairs: (cards) ->
    cards ?= @cards
    # look at the last card played, then go through the stack in
    # reverse order to see how many match it
    cards = cards.concat().reverse()
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
    cards ?= @cards
    return 0 if cards.length < 3 # can only have runs of 3 or more
    score = 0
    _.each [cards.length - 3..0], (count) =>
      testRun = cards.slice(count).sort(Card.sort)
      if _.all(_.map(testRun, @isRun))
        score = _.max([score, testRun.length])
    score


  countFifteens: (cards) ->
    cards ?= @cards
    if _.reduce(cards, ((memo, card) -> memo += card.value()), 0) == 15 then 2 else 0

  countThirtyOnes: (cards) ->
    cards ?= @cards
    if _.reduce(cards, ((memo, card) -> memo += card.value()), 0) == 31 then 2 else 0

root = exports ? window
root.PeggingStack = PeggingStack
