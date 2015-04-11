assert = chai.assert
expect = chai.expect


describe "app constructor", ->

  describe "newGame", ->
    it "should start a new game upon initialization", ->
      app = new App()
      expect(app.newGameSetup).to.be.called 
    it "should ", ->
      app = new App()
      app.get('playerHand').bust()
      expect(app.trigger).to.be.called