chai = require 'chai'
chai.should()
CoffeeScript = require('coffee-script')
_ = require 'underscore'
CoffeeScript.register()
Player = require('../src/player.coffee').Player
Game = require('../src/game.coffee').Game


describe 'Player', ->
  beforeEach ->
    @player = new Player('Test Player', 'Blue')

  it 'adds to the score', ->
    @player.increaseScore(5)
    @player.score.should.equal 5
    @player.increaseScore(5)
    @player.score.should.equal 10
    @player.previousScore.should.equal 5

  it 'knows where the pegs are', ->
    @player.increaseScore(5)
    @player.increaseScore(5)
    @player.pegs().should.eql [10,5]

describe '2 Player Game', ->
  beforeEach ->
    @playerBlue = new Player('Jack Player', 'Blue')
    @playerRed = new Player('Jill Player', 'Red')
    @game = new Game([@playerBlue, @playerRed])

  it 'deals cards to the players', ->
    @game.deal()
    @playerBlue.hand.cards.length.should.equal 6
    @playerRed.hand.cards.length.should.equal 6

  it 'discovers a winner', ->
    @playerBlue.increaseScore(121)
    @playerBlue.score.should.equal 121
    @game.winner().should.equal @playerBlue

  it 'makes a player a dealer', ->


  it 'lets players put cards in crib', ->
    _.noop()
