Game = require('./game.coffee').Game
Player = require('./player.coffee').Player
Card = require('./card.coffee').Card
$ = require 'jquery'
Backbone = require 'backbone'
_ = require 'underscore'
Backbone.$ = $

CardView = require('./views/card_view.coffee').CardView


playerBlue = new Player('Jack Player', 'Blue')
playerRed = new Player('Jill Player', 'Red')
game = new Game([playerRed, playerBlue])
game.deal()

class App
  constructor: ->
    _.each [playerBlue, playerRed], (player) ->
      $('#app').append("<h2>#{player.name}</h2>")
      _.each player.hand.cards, (card) ->
        $('#app').append("<img width=100 src='#{card.url()}'/>")


$ ->
  app = new App()
