Backbone = require 'Backbone'
_ = require 'underscore'
$ = require 'jquery'
Backbone.$ = $

class BoardView extends Backbone.View
  className: 'board'

  render: (options) ->
    @$el


exports.BoardView = BoardView
