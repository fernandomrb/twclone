
App.notifications = App.cable.subscriptions.create('NotificationsChannel', {  
    received: function(data) {
      this.updateCounter();
      this.toastNotification(data);
    },
  
    updateCounter: function() {
        counter = document.getElementById("notification-counter");
        val = parseInt(counter.innerText);
        val++;
        counter.innerText = val;
    },

    toastNotification: function(data) {
        toastHeader = document.querySelector(".toast-header");
        toastHeader.querySelector(".user").innerText = data.user.name;
        toastHeader.querySelector(".user-avatar").src = data.user.avatar.url;
        document.querySelector(".toast-body").innerText = data.message;

        this.launchToast();
    },
    launchToast: function() {
		toast = document.getElementById('toast');
		toast.classList.add("show");
		setTimeout(function(){
			toast.classList.remove("show");
		}, 5000)
	}
});
