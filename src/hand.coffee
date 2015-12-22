_ = require 'underscore'
Card = require('./card').Card
CardSet = require('./card_set').CardSet

class Hand extends CardSet

  constructor: (deck) ->
    @deck = deck
    super()

  toScore = (cards...) ->
    (_.map _.flatten(cards), (card) -> card.rank + card.suit).sort().join()

  toCrib: (card...) ->
    card = @find(card...)
    @deck.crib.add(card)
    @remove(card)

  discard: (card...) ->
    card = @find(card...)
    @deck.discards.add card
    @remove(card)
    card

  withCut: ->
    _.flatten [@cards, @deck.cut]

  score: ->
    @decc
    score = 0
    score += @countFifteens(@withCut())
    score += @countPairs(@withCut())
    score += @countFlushes(@cards, @deck.cut)

  countRuns: (cards) ->
    score = 0
    scored = []
    scoreRuns = (cards, otherCards) ->
      low = @rankVal(_.first(cards))
      high = @rankVal(_.last(cards))
      _.each otherCards, (otherCard) ->
        cardVal = @rankVal(otherCard)
        if cardVal = low - 1 || cardVal = high + 1
          cards = _.flatten([cards, otherCard]).sort(Card.sort)

  rankVal: (card) ->
    @ranks.indexOf(card.rank) + 1

  countFlushes: (cards, cut) ->
    score = 0
    score = 4 if _.uniq(_.map(cards, (card) => card.suit)).length == 1
    # only score the cut card as part of the flush if we already have the flush
    score = 5 if cut.suit == cards[0].suit and score == 4
    score

  countPairs: (cards) ->
    score = 0
    scored = []
    _.each cards, (card) ->
      otherCards = _.reject(cards, (c) -> c == card)
      _.each otherCards, (otherCard) ->
        if otherCard.rank == card.rank and toScore(card, otherCard) not in scored
          score += 2
          scored.push(toScore(card, otherCard))
    score

  countFifteens: (cards) ->
    score = 0
    scored = []

    scoreFifteens = (cards, otherCards) ->
      val = _.reduce(cards, ((memo, card) -> memo += card.value()), 0)
      _.each otherCards, (otherCard) ->
        if otherCard.value() + val == 15 and toScore(cards, otherCard) not in scored
          score += 2
          scored.push(toScore(cards, otherCard))
        if val + otherCard.value() < 15
          scoreFifteens(_.flatten([cards, otherCard]), _.reject(otherCards, (c) -> c == otherCard))
    _.each cards, (card) ->
      scoreFifteens([card], _.reject(cards, (c) -> c == card))
    score

root = exports ? window
root.Hand = Hand
