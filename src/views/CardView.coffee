class window.CardView extends Backbone.View
  className: 'card'

  template: _.template ''

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    @$el.addClass 'covered' unless @model.get 'revealed'

    bgUrl = "url('img/cards/#{@model.get('rankName')}-#{@model.get('suitName')}.png')"
    @$el.css({
      'background': bgUrl,
      'background-size': '100px, 140px'
    })
    if not @model.get 'revealed'
      @$el.css({
      'background': "url('img/card-back.png')",
      'background-size': '100px, 140px'
      })