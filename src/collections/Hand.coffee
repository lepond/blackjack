class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->
    console.log ""@scores()

  hit: ->
    @add(@deck.pop())
    if @maxScore() > 21 then @bust()

  bust: ->
    @trigger 'bust'

  stand: ->
    @trigger 'stand'

  dealerDraw: ->
    @first().flip()
    while @maxScore() < 17 
      @hit()

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  maxScore: -> 
    if @scores()[1] <= 21 then @scores()[1]
    else @scores()[0]

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]


