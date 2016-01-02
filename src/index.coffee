Game = require('./game.coffee').Game
Player = require('./player.coffee').Player
Card = require('./card.coffee').Card
$ = require 'jquery'
Backbone = require 'backbone'
_ = require 'underscore'
Backbone.$ = $

CardView = require('./views/card_view.coffee').CardView
CardSetView = require('./views/card_set_view.coffee').CardSetView
BoardView = require('./views/board_view.coffee').BoardView

class App
  constructor: ->
    playerBlue = new Player('Jack Player', 'Blue')
    playerRed = new Player('Jill Player', 'Red')
    game = new Game([playerRed, playerBlue])
    game.deal()
    blueHand = new CardSetView(playerBlue.hand)
    redHand = new CardSetView(playerRed.hand)
    $('#app').append blueHand.render({ faceUp: false })
    $('#app').append redHand.render()
    board = new BoardView()
    $('#app').append board.render()
$ ->
  app = new App()
