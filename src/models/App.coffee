# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @newGameSetup()
    @set 'bank', new Bank(balance: 1000, betAmount: 100)
    @set 'bankView', new BankView(model: @get 'bank')

  newGame: ->
    @newGameSetup()
    @trigger 'newGame'
    if @get('playerHand').maxScore() == 21
      @get('playerHand').stand()

  newGameSetup: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on 'bust', => 
      @trigger 'playerLoses'
      @get('bank').trigger 'loseBet'

    @get('dealerHand').on 'bust', => 
      @trigger 'playerWins'
      @get('bank').trigger 'winBet'

    @get('playerHand').on 'stand', => 
      @get('dealerHand').dealerDraw()
      playerScore = @get('playerHand').maxScore()
      dealerScore = @get('dealerHand').maxScore()

      if dealerScore < playerScore && dealerScore <= 21
        @trigger 'playerWins'
        @get('bank').trigger 'winBet'
      if dealerScore > playerScore && dealerScore <= 21
        @trigger 'playerLoses'
        @get('bank').trigger 'loseBet'
      if dealerScore == playerScore 
        @trigger 'tieGame'
    