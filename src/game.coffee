_ = require 'underscore'
Deck = require('./deck').Deck

class Game

  constructor: (players) ->
    @players = players
    @deck = new Deck()
    @cardsToDeal = if @players.length == 2 then 6 else 5

  makeDealer: (player) ->
    _.each @players, (p) -> p.dealer = false
    player.dealer = true

  dealer: ->
    _.find(@players, (player) -> player.dealer)

  deal: ->
    @deck.shuffle()
    @deck.deal(_.map(@players, (player) -> player.hand), @cardsToDeal)

  winner: ->
    _.find(@players, (player) -> player.score >= 121)



root = exports ? window
root.Game = Game
