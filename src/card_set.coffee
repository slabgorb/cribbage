_ = require 'underscore'
Card = require('./card').Card

class CardSet
  suits: ['Clubs','Diamonds','Hearts','Spades']
  ranks: ['A','2','3','4','5','6','7','8','9','10','J','Q','K']

  constructor: ->
    @cards = []

  toScore = (cards...) ->
    (_.map _.flatten(cards), (card) -> card.rank + card.suit).sort().join()

  count: ->
    @cards.length

  isRun: (card, index, cards) ->
    if index == cards.length - 1 then true else  (card.rankVal() + 1) == cards[index + 1].rankVal()

  sort: ->
    _.sortBy @cards, (card) => (@ranks.indexOf(card.rank) * 5) + (@suits.indexOf(card.suit))

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

  rankVal: (card) ->
    card.rankVal()

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
root.CardSet = CardSet
