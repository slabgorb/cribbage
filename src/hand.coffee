_ = require 'underscore'
Card = require('./card').Card
CardSet = require('./card_set').CardSet

class Hand extends CardSet

  constructor: (deck) ->
    @deck = deck
    @played = []
    super()

  play: (card) ->
    @played.push card

  playableCards: ->
    _.difference(cards, played)

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
    score += @countRuns(@withCut())
    score += @countNobs(@cards, @deck.cut)

  countNobs: (cards, cut) ->
    _.filter(cards, (card) -> card.rank == 'J' and card.suit == cut.suit).length

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



    runCombinations = _.filter(_.map(combos(cards, 3), (cmbo) => cmbo.sort(Card.sort)), (c) => _.all(_.map(c, @isRun)))
    return 0 if runCombinations.length == 0
    maxLength = _.max(_.map(runCombinations, (r) -> r.length))
    _.filter(runCombinations, (r) -> r.length == maxLength).length * maxLength



  countFlushes: (cards, cut) ->
    score = 0
    score = 4 if _.uniq(_.map(cards, (card) => card.suit)).length == 1
    # only score the cut card as part of the flush if we already have the flush
    score = 5 if cut.suit == cards[0].suit and score == 4
    score






root = exports ? window
root.Hand = Hand
