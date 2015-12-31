Game = require('./game.coffee').Game
Player = require('./player.coffee').Player


playerBlue = new Player('Jack Player', 'Blue')
playerRed = new Player('Jill Player', 'Red')
game = new Game([playerRed, playerBlue])
console.log game.scores()
