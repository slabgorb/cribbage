Backbone = require 'Backbone'
_ = require 'underscore'
$ = require 'jquery'
Backbone.$ = $

class CardView extends Backbone.View
  className = 'card'

  initialize: (card, back) ->
    @card = card
    @back = back

  faceUp: ->
    "./svg/faces/#{@card.rank}_#{@card.suit}.svg"

  faceDown: ->
    "./svg/backs/back_#{@back}.svg"

  render: (options = { faceUp: true } ) ->
    svg = if options.faceUp? then @faceUp() else @faceDown
    @$el.css('background-image', "url(#{@svg()})")
    console.log 'hello'
    @$el

exports.CardView = CardView
