App.twitter_feed = App.cable.subscriptions.create("TwitterFeedChannel", {

  connected: function() {
    console.log('connected');
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    console.log(data);
    // Called when there's incoming data on the websocket for this channel
  }
});
