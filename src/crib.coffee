Hand = require('./hand').Hand

class Crib extends Hand

  countFlushes: (cards, cut) ->
    score = 0
    score = 5 if cut.suit == cards[0].suit and score == 4
    score
