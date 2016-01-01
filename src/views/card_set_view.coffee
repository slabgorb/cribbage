CardView = require '../views/card_view.coffee'.CardView
Backbone = require 'Backbone'
_ = require 'underscore'
$ = require 'jquery'
Backbone.$ = $

class CardSetView extends Backbone.View

  className = 'card-set'

  initialize: (cardSet) ->
    @cardSet = cardSet
    @childViews = []

  render: (options) ->
    console.log "card set", @cardSet
    _.each @cardSet.cards, (card) ->
      console.log card
      cv = new CardView(card)
      @childViews.push cv
      @$el.append(cv.render())
      @$el

exports.CardSetView = CardSetView
