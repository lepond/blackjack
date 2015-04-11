class window.BankView extends Backbone.View
  el: $('.bank-container')

  className: 'bank'
  template: _.template '<h2>Bank</h2><div>Balance: <%= balance %></div><div>Bet: <%= betAmount %></div><div class="increase-bet">+10</div><div class="decrease-bet">-10</div>'

  initialize: ->
    @render()
    @model.on 'change', => @render()
    @model.on 'loseBet', => @model.set('balance', @model.get('balance')-@model.get('betAmount'))
    @model.on 'winBet', => @model.set('balance', @model.get('balance')+@model.get('betAmount'))

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    @$el.css({
      'height': '400px',
      'width': '400px'
    })

  events: {
    'click .increase-bet': ->
      @model.set('betAmount', @model.get('betAmount')+10)
    'click .decrease-bet': ->
      @model.set('betAmount', @model.get('betAmount')-10)
  }
