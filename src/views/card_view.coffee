Backbone = require 'Backbone'
_ = require 'underscore'
$ = require 'jquery'
Backbone.$ = $

class CardView extends Backbone.View
  className: 'card'
  tagName: 'li'

  initialize: (card, back, up = true) ->
    @card = card
    @cardBack = back
    @up = up

  # events:
  #   'click': 'eventClick'

  eventClick: ->
    @flip()
    @render()

  flip: ->
    @up = not @up

  front: ->
    "./svg/faces/#{@card.rank}_#{@card.suit}.svg"

  back: ->
    "./svg/backs/back_#{@cardBack}.svg"

  render: ( options ) ->
    image = if @up then @front() else @back()
    @$el.css('background-image', "url(#{image})")
    @$el

exports.CardView = CardView
