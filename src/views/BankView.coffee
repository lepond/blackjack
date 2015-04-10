class window.BankView extends Backbone.View
  el: $('.bank-container')
  
  className: 'bank'
  template: _.template '<h2>Bank</h2><div>Balance: <%= balance %></div><div>Bet: <%= betAmount %></div>'

  initialize: ->
    @render()

  render: ->
    console.log 'render'
    @$el.children().detach()
    @$el.html @template @model.attributes
    @$el.css({
      'height': '400px',
      'width': '400px'
    })

