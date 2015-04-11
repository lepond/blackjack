class window.BankView extends Backbone.View
  el: $('.bank-container')

  className: 'bank'
  template: _.template '<div>Balance: <%= balance %></div><div>Bet: <%= betAmount %></div><button class="increase-bet btn btn-success">+10</button><button class="decrease-bet btn btn-danger">-10</button>'

  initialize: ->
    @render()
    @model.on 'change', => @render()
    @model.on 'loseBet', => @model.set('balance', @model.get('balance')-@model.get('betAmount'))
    @model.on 'winBet', => @model.set('balance', @model.get('balance')+@model.get('betAmount'))

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes

  events: {
    'click .increase-bet': ->
      @model.set('betAmount', @model.get('betAmount')+10)
    'click .decrease-bet': ->
      @model.set('betAmount', @model.get('betAmount')-10)
  }
