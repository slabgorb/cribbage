chai = require 'chai'
chai.should()
CoffeeScript = require('coffee-script')
CoffeeScript.register()
Deck = require('../src/deck.coffee').Deck



describe 'Deck', ->

  it 'creates a deck of 52 cards', ->
    deck = new Deck()
    deck.cards.length.should.equal 52
    deck.discards.length.should.equal 0

  it 'discards the top card from the deck', ->
    deck = new Deck()
    discard = deck.discard()
    discard.suit.should.equal 'Spades'
    discard.rank.should.equal 'A'
    deck.discards.length.should.equal 1
