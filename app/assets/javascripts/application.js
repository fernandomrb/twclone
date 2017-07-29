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
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .

$(document).on('turbolinks:load', function() {

	$(function () {
	  $('[data-toggle="tooltip"]').tooltip()
	});
	
	$(".tweet .btn-action a").on("click", function(e) {
		e.preventDefault();	
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

	function tweetLength() {
		var maxLength = $(".tweet-area").attr('maxLength');
		$(".tweet-area").on("input", function(event) {
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
	
	$("#modal-tweet").on("shown.bs.modal", function() {
		tweetLength();
		$(".modal-body .tweet-area").attr('rows', '2');
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

});
