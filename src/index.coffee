Game = require('./game.coffee').Game
Player = require('./player.coffee').Player
Card = require('./card.coffee').Card
$ = require 'jquery'
Backbone = require 'backbone'
_ = require 'underscore'
Backbone.$ = $

CardView = require('./card_view.coffee').CardView
CardSetView = require('./card_set_view.coffee').CardSetView

class App
  constructor: ->
    playerBlue = new Player('Jack Player', 'Blue')
    playerRed = new Player('Jill Player', 'Red')
    game = new Game([playerRed, playerBlue])
    game.deal()
    blueHand = new CardSetView(playerBlue.hand)
    redHand = new CardSetView(playerRed.hand)
    $('#app').append('red hand')
    $('#app').append(blueHand.render())
    # $('#app').append(redHand.render())

$ ->
  app = new App()
