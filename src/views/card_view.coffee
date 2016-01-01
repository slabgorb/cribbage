Card = require '../card.coffee'.Card
Backbone = require 'Backbone'
_ = require 'underscore'
$ = require 'jquery'
Backbone.$ = $

class CardView extends Backbone.View
  className = 'card'

  initialize: (card) ->
    @card = card

  svg: ->
    "./svg/faces/#{@card.rank}_#{@card.suit}.svg"

  render: ->
    @$el.css('background-image', "url(#{@svg()})")
    @$el

exports.CardView = CardView
