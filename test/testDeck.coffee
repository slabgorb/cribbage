chai = require 'chai'
chai.should()
CoffeeScript = require('coffee-script')
_ = require 'underscore'
CoffeeScript.register()
Deck = require('../src/deck.coffee').Deck
Card = require('../src/card.coffee').Card
Hand = require('../src/hand.coffee').Hand

describe 'Card', ->
  it 'knows its rank and suit', ->
    card = new Card('A','Spades')
    card.rank.should.equal 'A'
    card.suit.should.equal 'Spades'

  it 'knows the value of a A-9 card', ->
    card = new Card('A','Spades')
    card.value().should.equal 1
    card = new Card('2','Spades')
    card.value().should.equal 2
    card = new Card('9','Spades')
    card.value().should.equal 9

  it 'knows the value of a face card', ->
    card = new Card('J', 'Spades')
    card.value().should.equal 10
    card = new Card('K', 'Spades')
    card.value().should.equal 10
    card = new Card('Q', 'Spades')
    card.value().should.equal 10
    card = new Card('10', 'Spades')
    card.value().should.equal 10

describe 'Hand', ->
  beforeEach ->
    @deck = new Deck()
    @hand = new Hand(@deck)

  it 'starts with no cards', ->
    @hand.cards.length.should.equal 0

  it 'gets cards dealt to it', ->
    @deck.deal([@hand], 5)
    @hand.count().should.equal 5

  it 'finds a card', ->
    @deck.deal([@hand], 5)
    @hand.find('A','Spades').rank.should.equal 'A'
    @hand.find('A','Spades').suit.should.equal 'Spades'
    @hand.find(1).suit.should.equal 'Spades'
    @hand.find(_.first(@hand.cards)).suit.should.equal 'Spades'


  it 'discards', ->
    @deck.deal([@hand], 5)
    @hand.discard(1).rank.should.equal '2'
    @hand.count().should.equal 4
    @deck.discards.count().should.equal 1
    @hand.discard('A','Spades')
    @hand.count().should.equal 3
    @deck.discards.count().should.equal 2

  it 'puts cards in the crib', ->
    @deck.deal([@hand], 6)
    @hand.toCrib(0)
    @hand.toCrib(0)
    @deck.crib.count().should.equal 2
    @hand.count().should.equal 4

  it 'scores two card fifteens', ->
    @hand.add(new Card('Q','Spades'))
    @hand.add(new Card('5','Diamonds'))
    @hand.add(new Card('8','Clubs'))
    @hand.add(new Card('7','Clubs'))
    @deck.cut = new Card('8','Spades')
    @hand.countFifteens(@hand.withCut()).should.equal 6

  it 'scores three card fifteens', ->
    @hand.add(new Card('3','Spades'))
    @hand.add(new Card('4','Diamonds'))
    @hand.add(new Card('8','Clubs'))
    @hand.add(new Card('10','Clubs'))
    @deck.cut = new Card('Q','Spades')
    @hand.countFifteens(@hand.withCut()).should.equal 2

  it 'scores four card fifteens', ->
    @hand.add(new Card('3','Spades'))
    @hand.add(new Card('4','Diamonds'))
    @hand.add(new Card('7','Clubs'))
    @hand.add(new Card('A','Clubs'))
    @deck.cut = new Card('9','Spades')
    @hand.countFifteens(@hand.withCut()).should.equal 2

  it 'scores five card fifteens', ->
    @hand.add(new Card('A','Spades'))
    @hand.add(new Card('4','Diamonds'))
    @hand.add(new Card('7','Clubs'))
    @hand.add(new Card('A','Clubs'))
    @deck.cut = new Card('2','Hearts')
    @hand.countFifteens(@hand.withCut()).should.equal 2


  it 'scores simple pairs', ->
    @hand.add(new Card('A','Spades'))
    @hand.add(new Card('4','Diamonds'))
    @hand.add(new Card('7','Clubs'))
    @hand.add(new Card('A','Clubs'))
    @deck.cut = new Card('2','Hearts')
    @hand.countPairs(@hand.withCut()).should.equal 2

  it 'scores three of a kind', ->
    @hand.add(new Card('A','Spades'))
    @hand.add(new Card('A','Diamonds'))
    @hand.add(new Card('7','Clubs'))
    @hand.add(new Card('A','Clubs'))
    @deck.cut = new Card('2','Hearts')
    @hand.countPairs(@hand.withCut()).should.equal 6

  it 'scores four of a kind', ->
    @hand.add(new Card('A','Spades'))
    @hand.add(new Card('A','Diamonds'))
    @hand.add(new Card('7','Clubs'))
    @hand.add(new Card('A','Clubs'))
    @deck.cut = new Card('A','Hearts')
    @hand.countPairs(@hand.withCut()).should.equal 12


describe 'Deck', ->

  beforeEach ->
    @deck = new Deck()

  it 'cuts the cards', ->
    @deck.cutCard().should.be.instanceOf(Card)

  it 'creates a deck of 52 cards', ->
    @deck.count().should.equal 52
    @deck.discards.count().should.equal 0

  it 'discards the top card from the deck', ->
    discard = @deck.discard()
    discard.suit.should.equal 'Spades'
    discard.rank.should.equal 'A'
    @deck.discards.count().should.equal 1

  it 'deals cards', ->
    [hand1, hand2] = [new Hand(@deck), new Hand(@deck)]
    @deck.deal([hand1, hand2], 5)
    hand1.cards.length.should.equal 5
    hand2.cards.length.should.equal 5
    _.map(hand1.cards, (card) -> card.rank).should.include.members(['A','3','5','7','9'])
    _.map(hand2.cards, (card) -> card.rank).should.include.members(['2','4','6','8','10'])
    @deck.count().should.equal 42
