_ = require 'underscore'
Hand = require('./hand').Hand
class Player

  @colors = ['Blue', 'Green', 'Red']

  constructor: (name, color) ->
    @name = name
    @color = color
    @score = 0
    @previousScore = 0
    @hand = new Hand()
    @dealer = false

  increaseScore: (number) ->
    @previousScore = @score
    @score += number
    @score = _.min([@score, 121])

  pegs: ->
    [@score, @previousScore]

  isDealer: -> @dealer



root = exports ? window
root.Player = Player
