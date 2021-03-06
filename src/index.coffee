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
    blueHand = new CardSetView(el: '#blue-hand', cardSet: playerBlue.hand)
    redHand = new CardSetView(el: '#red-hand', cardSet: playerRed.hand)
    blueHand.render( faceUp: false )
    redHand.render()
    board = new BoardView(el: '#board')
    board.render()
$ ->
  app = new App()
