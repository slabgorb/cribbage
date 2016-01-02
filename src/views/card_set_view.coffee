CardView = require('./card_view.coffee').CardView
Backbone = require 'Backbone'
_ = require 'underscore'
$ = require 'jquery'
Backbone.$ = $

class CardSetView extends Backbone.View

  className: 'card-set'
  tagName: 'ul'

  initialize: (el, cardSet) ->
    @cardSet = cardSet
    @childViews = []

  render: (options) ->
    _.each @cardSet.cards, (card) =>
      cv = new CardView(card)
      @childViews.push cv
      @$el.append(cv.render())
    @$el

exports.CardSetView = CardSetView
