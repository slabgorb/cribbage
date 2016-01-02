Backbone = require 'Backbone'
_ = require 'underscore'
$ = require 'jquery'
Backbone.$ = $

class CardView extends Backbone.View
  className: 'card'
  tagName: 'li'

  initialize: (card, back) ->
    @card = card
    @back = back

  front: ->
    "./svg/faces/#{@card.rank}_#{@card.suit}.svg"

  back: ->
    "./svg/backs/back_#{@back}.svg"

  render: (options = { faceUp: true } ) ->
    svg = if options.faceUp? then @front() else @back()
    @$el.css('background-image', "url(#{svg})")
    @$el

exports.CardView = CardView
