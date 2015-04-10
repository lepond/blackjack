# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @newGameSetup()

  newGame: ->
    @newGameSetup()
    @trigger 'newGame'

  newGameSetup: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @get('playerHand').on 'bust', => 
      @trigger 'playerLoses'

    @get('dealerHand').on 'bust', => 
      @trigger 'playerWins'

    @get('playerHand').on 'stand', => 
      @get('dealerHand').dealerDraw()
      playerScore = @get('playerHand').minScore()
      dealerScore = @get('dealerHand').minScore()
      if dealerScore < playerScore && dealerScore <= 21
        @trigger 'playerWins'
      if dealerScore > playerScore && dealerScore <= 21
        @trigger 'playerLoses'
      if dealerScore == playerScore 
        @trigger 'tieGame'
    