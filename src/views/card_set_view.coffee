CardView = require('./card_view.coffee').CardView
Backbone = require 'Backbone'
_ = require 'underscore'
$ = require 'jquery'
Backbone.$ = $
require 'jquery-ui-browserify'

class CardSetView extends Backbone.View

  initialize: (options) ->
    @el = options.el
    @cardSet = options.cardSet
    @childViews = []

  render: (options = { faceUp: true }) ->
    _.each @cardSet.cards, (card) =>
      cv = new CardView(card, '01', options.faceUp)
      @childViews.push cv
      @$el.append(cv.render())
    _.defer( => @$el.sortable())
    @$el

exports.CardSetView = CardSetView
