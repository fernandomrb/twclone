
App.notifications = App.cable.subscriptions.create('NotificationsChannel', {  
    received: function(data) {
        console.log(data.message)
      return updateCounter(data);
    },
  
    updateCounter: function(data) {
        counter = $("#notification-counter");
        val = parseInt(counter.text);
        val++;
        counter.html(val);
    }
});
