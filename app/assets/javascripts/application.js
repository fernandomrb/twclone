// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require jquery3
//= require jquery_ujs
//= require bootstrap
//= require tribute
//= require_tree ./channels
//= require_tree .

$(document).on('turbolinks:load', function() {

	if (parseInt($("#notification-counter").text()) === 0) {
		$("#notification-counter").addClass("hide");
	} 

	$(function () {
	  $('[data-toggle="tooltip"]').tooltip()
	});
	
	// ********************** new tweet form ****************************************
	$(".jumbotron .tweet-area").focus(function(e) {
		$(this).attr('rows', '3');
		$(".form-group .pull-right").show();
		tweetLength();
	});
	$(".jumbotron .tweet-area").blur(function(e) {
		if ($(this).val() === "") {
			minimizeTweetForm();
		} 
	});
	$(".jumbotron .new_tweet").submit(function(e) {
			minimizeTweetForm();
	});

	function minimizeTweetForm() {
		$(".jumbotron .tweet-area").attr('rows', '1');
		$(".form-group .pull-right").hide();
	} 

	function tweetLength(modal = false) {
		var tweet_area;
		if (modal) {
			tweet_area = $(".modal .tweet-area")
		} else {
			tweet_area = $(".tweet-area")
		}
		var maxLength = tweet_area.attr('maxLength');
		 tweet_area.on("input", function(event) {
			var length = $(this).val().length;
			var length = maxLength - length;
			var span = $(".remaining");
			if(length <= 20) {
				span.addClass('text-danger');
			} else {
				span.removeClass('text-danger');
			}
			span.text(length);
		});
	}
	// *************************************************************************************
	
	$(".tweet .tweet-actionable").on("click", function(e) {
		if (e.target === this ) {
		 window.location = $(this).attr("data-url");
		}
	});
	
	$(".modal").on("shown.bs.modal", function() {
		if(document.querySelector(".tweet-area")) {
			tweetLength(true);
			$(".modal-body .tweet-area").attr('rows', '2');
		}
	});
	$(document).on("focus","#tweet_body",function(e){
		$(this).attr('rows', '3');
		$(".form-group .pull-right").show();
		tweetLength();
	});

	$(document).ajaxError(function(event,xhr,options,exc) {
	    
	    var errors = JSON.parse(xhr.responseText);
	    var er ="<ul>";
	    for(var i = 0; i < errors.length; i++){
	        var list = errors[i];
	        er += "<li>"+list+"</li>"
	    }
	    er+="</ul>"
	    $("#error_explanation").html(er);
	       
	});

	$("#notification-counter").on("DOMSubtreeModified", function() {
		toggleCounter(this);
	});
	$("#messages-counter").on("DOMSubtreeModified", function() {
		toggleCounter(this);
	});

	var toggleCounter = function(ele) {
		val = ele.innerText;
		if (parseInt(val) === 0) {
			ele.classList.add("hide");
		} else {
			ele.classList.remove("hide");
		}
	};


	var tribute = new Tribute({
		values: function (text, cb) {
			remoteSearch(text, users => cb(users));
		},
		lookup: function (person, mentionText) {
			return person.name + " <small>@" + person.username + "</small>";
		},
		fillAttr: 'username',
		menuItemTemplate: function (item) {
			return '<img class ="user-avatar" src="'+item.original.avatar+'">' + item.string; // + '<small>@'+ item.original.username +'</small>';
		}
	});

	tribute.attach(document.querySelectorAll('.tweet-area'));

	function remoteSearch(text, cb) {
		var URL = '/users.json';
		xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function ()
		{
			if (xhr.readyState === 4) {
				if (xhr.status === 200) {
					var data = JSON.parse(xhr.responseText);
					cb(data);
				} else if (xhr.status === 403) {
					cb([]);
				}
			}
		};
		xhr.open("GET", URL + "?term=" + text, true);
		xhr.send();
	}
	
});
