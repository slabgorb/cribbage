CardView = require('./card_view.coffee').CardView
Backbone = require 'Backbone'
_ = require 'underscore'
$ = require 'jquery'
Backbone.$ = $

class CardSetView extends Backbone.View

  className: 'card-set'
  tagName: 'ul'

  initialize: (cardSet) ->
    @cardSet = cardSet
    @childViews = []

  render: (options = { faceUp: true }) ->
    _.each @cardSet.cards, (card) =>
      cv = new CardView(card, '00', options.faceUp)
      @childViews.push cv
      @$el.append(cv.render())
    @$el

exports.CardSetView = CardSetView
