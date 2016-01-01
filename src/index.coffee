Game = require('./game.coffee').Game
Player = require('./player.coffee').Player
$ = require 'jquery'
Backbone = require 'backbone'
_ = require 'underscore'
Backbone.$ = $


playerBlue = new Player('Jack Player', 'Blue')
playerRed = new Player('Jill Player', 'Red')
game = new Game([playerRed, playerBlue])
console.log game.scores()

card = new Card('A', 'Spades')

card.display
