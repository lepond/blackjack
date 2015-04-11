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
      @$el.prepend('<center><div class="game-result-lose alert alert-danger">You lost.</div></center>')
      $('.game-result-lose').hide().fadeIn().delay(1000).fadeOut()
      setTimeout(@model.newGame.bind(@model), 1800)
    @model.on 'playerWins', => 
      @$el.prepend '<center><div class="game-result-win alert alert-success">You win!</div></center>'
      $('.game-result-win').hide().fadeIn().delay(1000).fadeOut()
      setTimeout(@model.newGame.bind(@model), 1800)
    @model.on 'tieGame', => 
      @$el.prepend '<center><div class="game-result-tie alert alert-warning">You tied!</div></center>'
      $('.game-result-tie').hide().fadeIn().delay(1000).fadeOut()
      setTimeout(@model.newGame.bind(@model), 1800)
    @model.on 'newGame', => 
      @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
