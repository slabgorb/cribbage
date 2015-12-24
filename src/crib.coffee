_ = require 'underscore'
Hand = require('./hand').Hand

class Crib extends Hand

  countFlushes: (cards, cut) ->
    score = 0
    score = 5 if _.uniq(_.map(_.flatten([cards, cut]), (card) => card.suit)).length == 1
    score


root = exports ? window
root.Crib = Crib
