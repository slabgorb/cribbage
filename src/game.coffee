_ = require 'underscore'
Deck = require('./deck.coffee').Deck
PeggingStack = require('./pegging_stack.coffee').PeggingStack

class Game

  constructor: (players) ->
    @players = players
    @deck = new Deck()
    @cardsToDeal = if @players.length == 2 then 6 else 5
    @peggingStack = new PeggingStack()

  makeDealer: (player) ->
    _.each @players, (p) -> p.dealer = false
    player.dealer = true

  dealer: ->
    _.find(@players, (player) -> player.dealer)

  deal: ->
    @deck.shuffle()
    @deck.deal(_.map(@players, (player) -> player.hand), @cardsToDeal)

  scores: ->
    _.map @players, (player) ->
      name: player.name
      score: player.score

  winner: ->
    _.find(@players, (player) -> player.score >= 121)

  scorePegging: (player) ->
    score = 0
    score += @peggingStack.countFifteens()
    score += @peggingStack.countPairs()
    score += @peggingStack.countRuns()
    score += @peggingStack.countThirtyOnes()
    player.increaseScore(score)

  playCard: (card, player) ->
    player.hand.play(card)
    @peggingStack.add card
    @scorePegging(player)


root = exports ? window
root.Game = Game
