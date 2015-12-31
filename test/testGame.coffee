require './common'
_ = require 'underscore'
Player = require('../src/player.coffee').Player
Game = require('../src/game.coffee').Game
Card = require('../src/card.coffee').Card

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
    @game.makeDealer(@playerBlue)
    @game.dealer().should.equal @playerBlue

  it 'lets players put cards in crib', ->
    _.noop()

describe 'pegging', ->
  beforeEach ->
    @playerBlue = new Player('Jack Player', 'Blue')
    @playerRed = new Player('Jill Player', 'Red')
    @game = new Game([@playerBlue, @playerRed])

  it 'counts pairs in pegging', ->
    @game.playCard(new Card('3','Clubs'), @playerRed)
    @game.playCard(new Card('2','Spades'), @playerBlue)
    @game.playCard(new Card('2','Clubs'), @playerRed)
    @game.peggingStack.countPairs().should.equal 2

  it 'counts three of a kind in pegging', ->
    @game.playCard(new Card('2','Spades'), @playerBlue)
    @game.playCard(new Card('2','Clubs'), @playerRed)
    @game.playCard(new Card('2','Diamonds'), @playerRed)
    @game.peggingStack.countPairs().should.equal 6

  it 'counts four of a kind in pegging', ->
    @game.playCard(new Card('2','Spades'), @playerBlue)
    @game.playCard(new Card('2','Clubs'), @playerRed)
    @game.playCard(new Card('2','Diamonds'), @playerBlue)
    @game.playCard(new Card('2','Hearts'), @playerRed)
    @game.peggingStack.countPairs().should.equal 12

  it 'knows not to count pairs if something breaks it up', ->
    @game.playCard(new Card('2','Spades'), @playerBlue)
    @game.playCard(new Card('3','Clubs'), @playerRed)
    @game.playCard(new Card('2','Diamonds'), @playerBlue)
    @game.peggingStack.countPairs().should.equal 0

  it 'counts fifteens with two cards', ->
    @game.playCard(new Card('10','Spades'), @playerBlue)
    @game.playCard(new Card('5','Clubs'), @playerRed)
    @game.peggingStack.countFifteens().should.equal 2

  it 'counts fifteens with three cards', ->
    @game.playCard(new Card('7','Spades'), @playerBlue)
    @game.playCard(new Card('7','Clubs'), @playerRed)
    @game.playCard(new Card('A','Clubs'), @playerBlue)
    @game.peggingStack.countFifteens().should.equal 2

  it 'counts fifteens with no fifteens', ->
    @game.playCard(new Card('7','Spades'), @playerBlue)
    @game.playCard(new Card('7','Clubs'), @playerRed)
    @game.playCard(new Card('2','Clubs'), @playerBlue)
    @game.peggingStack.countFifteens().should.equal 0

  it 'counts thirty-ones', ->
    @game.playCard(new Card('10','Spades'), @playerBlue)
    @game.playCard(new Card('Q','Clubs'), @playerRed)
    @game.playCard(new Card('J','Clubs'), @playerBlue)
    @game.playCard(new Card('A','Clubs'), @playerRed)
    @game.peggingStack.countThirtyOnes().should.equal 2

  it 'recognizes no runs', ->
    @game.playCard(new Card('10','Spades'), @playerBlue)
    @game.playCard(new Card('A','Clubs'), @playerRed)
    @game.playCard(new Card('J','Clubs'), @playerBlue)
    @game.peggingStack.countRuns().should.equal 0

  it 'counts runs of 3', ->
    @game.playCard(new Card('10','Spades'), @playerBlue)
    @game.playCard(new Card('Q','Clubs'), @playerRed)
    @game.playCard(new Card('J','Clubs'), @playerBlue)
    @game.peggingStack.countRuns().should.equal 3

  it 'counts runs of 4', ->
    @game.playCard(new Card('A','Spades'), @playerBlue)
    @game.playCard(new Card('2','Clubs'), @playerRed)
    @game.playCard(new Card('3','Clubs'), @playerBlue)
    @game.playCard(new Card('4','Clubs'), @playerRed)
    @game.peggingStack.countRuns().should.equal 4

  it 'counts runs of 5', ->
    @game.playCard(new Card('A','Spades'), @playerBlue)
    @game.playCard(new Card('2','Clubs'), @playerRed)
    @game.playCard(new Card('3','Clubs'), @playerBlue)
    @game.playCard(new Card('4','Clubs'), @playerRed)
    @game.playCard(new Card('5','Clubs'), @playerBlue)
    @game.peggingStack.countRuns().should.equal 5

  it 'counts runs of 6', ->
    @game.playCard(new Card('A','Spades'), @playerBlue)
    @game.playCard(new Card('2','Clubs'), @playerRed)
    @game.playCard(new Card('3','Clubs'), @playerBlue)
    @game.playCard(new Card('4','Clubs'), @playerRed)
    @game.playCard(new Card('5','Clubs'), @playerBlue)
    @game.playCard(new Card('6','Clubs'), @playerRed)
    @game.peggingStack.countRuns().should.equal 6

  it 'scores 15 pegging for a player', ->
    @game.playCard(new Card('10','Spades'), @playerBlue)
    @game.playCard(new Card('5','Clubs'), @playerRed)
    @playerRed.score.should.equal 2

  it 'scores pair pegging for a player', ->
    @game.playCard(new Card('10','Spades'), @playerBlue)
    @game.playCard(new Card('10','Clubs'), @playerRed)
    @playerRed.score.should.equal 2

  it 'scores a pegging series', ->
    @game.playCard(new Card('10','Spades'), @playerBlue)
    @game.playCard(new Card('5','Clubs'), @playerRed)
    @game.peggingStack.countFifteens().should.equal 2
    @game.peggingStack.countRuns().should.equal 0
    @game.peggingStack.countPairs().should.equal 0
    @playerBlue.score.should.equal 0
    @playerRed.score.should.equal 2
    @game.playCard(new Card('5','Diamonds'), @playerBlue)
    @game.peggingStack.countPairs().should.equal 2
    @game.peggingStack.countRuns().should.equal 0
    @game.peggingStack.countFifteens().should.equal 0
    @playerBlue.score.should.equal 2
    @playerRed.score.should.equal 2
    @game.playCard(new Card('10','Clubs'), @playerRed)
    @game.peggingStack.countPairs().should.equal 0
    @game.playCard(new Card('A','Spades'), @playerBlue)
    @game.peggingStack.countThirtyOnes().should.equal 2
    @playerBlue.score.should.equal 4
    @playerRed.score.should.equal 2
