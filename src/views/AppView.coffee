class window.AppView extends Backbone.View
  template: _.template "
    <h1>Black Jack</h1>
    <center>
    <div class='buttons'>
    <button class='hit-button btn btn-primary'>Hit</button> 
    <button class='stand-button btn btn-warning'>Stand</button> 
    <button class='new-game-button btn btn-info'>New Game</button>
    </div>
    </center>
    <hr>
    <div class='player-hand-container'></div>
    <div class='dealer-hand-container'></div>
  "

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()
    'click .new-game-button': -> @model.newGame()

  initialize: ->
    @render()
    @model.on 'playerLoses', => 
      @$el.prepend '<center><div class="game-result-lose">You lost.</div></center>'
    @model.on 'playerWins', => 
      @$el.prepend '<center><div class="game-result-win">You win!</div></center>'
    @model.on 'newGame', => 
      @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
