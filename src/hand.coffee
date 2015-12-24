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

    combos = (a, min) ->
      fn = (n, src, got, all) ->
        if n == 0
          if got.length > 0
            all[all.length] = got
          return
        j = 0
        while j < src.length
          fn n - 1, src.slice(j + 1), got.concat([ src[j] ]), all
          j++

      all = []
      i = min
      while i < a.length
        fn i, a, [], all
        i++
      all.push a
      all

    isRun = (card, index, cards) ->
      if index == cards.length - 1 then true else  (card.rankVal() + 1) == cards[index + 1].rankVal()

    runCombinations = _.filter(_.map(combos(cards, 3), (cmbo) -> cmbo.sort(Card.sort)), (c) -> _.all(_.map(c, isRun)))
    return 0 if runCombinations.length == 0
    maxLength = _.max(_.map(runCombinations, (r) -> r.length))
    _.filter(runCombinations, (r) -> r.length == maxLength).length * maxLength

  rankVal: (card) ->
    card.rankVal()

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
