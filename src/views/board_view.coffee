Backbone = require 'Backbone'
_ = require 'underscore'
$ = require 'jquery'
Backbone.$ = $

class BoardView extends Backbone.View

  initialize: (options) ->
    @el = options.el


exports.BoardView = BoardView
