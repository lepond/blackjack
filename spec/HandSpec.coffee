assert = chai.assert
expect = chai.expect

describe "hand constructor", ->

  describe "hit method", ->
    it "should have a hit method", ->
      hand = new Hand()
      expect(hand.hit).to.be.ok 
    it "should have a length of 4 after hit is called twice", ->
      deck = new Deck()
      hand = deck.dealPlayer()
      hand.hit()
      hand.hit()
      expect(hand.length).to.equal 4

  describe "bust method", ->
    it "should have a bust method", ->
      hand = new Hand()
      expect(hand.bust).to.be.ok 
    it "should call bust when maxScore is over 21", ->
      deck = new Deck()
      hand = new Hand([11,10], deck)
      hand.hit()
      expect(hand.bust).to.be.called

  it "should have a stand method", ->
    hand = new Hand()
    expect(hand.stand).to.be.ok 

  describe "dealerDraw method", ->
    it "should have a dealerDraw method", ->
      deck = new Deck()
      hand = deck.dealPlayer()
    it "should flip card when dealerDraw is invoked", ->
      deck = new Deck()
      hand = deck.dealPlayer()
      hand.dealerDraw()
      expect(deck.first().flip).to.be.called
    it "should hit if dealerScore is less than 17", ->
      deck = new Deck()
      hand = new Hand([1,2], deck)
      hand.dealerDraw()
      expect(hand.hit).to.be.called

  describe "hasAce method", ->
    it "should have a hasAce method", ->
      hand = new Hand()
      expect(hand.hasAce).to.be.ok 
    it "should equal false when no ace is present", ->
      deck = new Deck()
      card1 = new Card(rank: 0)
      hand = new Hand([card1,2], deck)
      expect(hand.hasAce()).to.equal false
    it "should equal true when ace is present", ->
      deck = new Deck()
      card1 = new Card(rank: 1)
      hand = new Hand([card1,2], deck)
      expect(hand.hasAce()).to.equal true

  describe "minScore method", ->
    it "should have a minScore method", ->
      hand = new Hand()
      expect(hand.minScore).to.be.ok 
    it "should calculate the minScore of two Cards", ->
      deck = new Deck()
      card1 = new Card(rank: 10)
      card2 = new Card(rank: 0)
      hand = new Hand([card1,card2], deck)
      expect(hand.minScore()).to.equal 20
    it "should ignore flipped cards", ->
      deck = new Deck()
      card1 = new Card(rank: 10)
      card2 = new Card(rank: 0)
      card2.flip()
      hand = new Hand([card1,card2], deck)
      expect(hand.minScore()).to.equal 10

  describe "maxScore method", ->
    it "should have a maxScore method", ->
      hand = new Hand()
      expect(hand.maxScore).to.be.ok
    it "should calculate the maxScore of two Cards when an ace is present", ->
      deck = new Deck()
      card1 = new Card(rank: 1)
      card2 = new Card(rank: 0)
      hand = new Hand([card1,card2], deck)
      expect(hand.maxScore()).to.equal 21

  describe "score method", ->
    it "should have a scores method", ->
      hand = new Hand()
      expect(hand.scores).to.be.ok
    it "should be an array with two values", ->
      deck = new Deck()
      card1 = new Card(rank: 5)
      card2 = new Card(rank: 1)
      hand = new Hand([card1,card2], deck)
      expect(hand.scores()[0]).to.equal 6
      expect(hand.scores()[1]).to.equal 16
