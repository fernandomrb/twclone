# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  $('#to').on "keyup", ->
    $.ajax '/users', 
        type: "GET",
        dataType: "JSON",
        data: { 
            term: $("#to").val()
        }
        asnyc: false,
        success: (data) ->
          if data.errors
            $(".people").html("<h3>#{ data.errors }</h3>")
          else
            $(".people").html("")
            $(".people").append("
              <li class='user' data-username=#{ data[i].username } data-user-id=#{ data[i].id }>
                <div class='avatar'>
                  <img src=#{ data[i].avatar } alt='user avatar' />
                </div>
                <div class='fullname'>
                  <strong>
                    #{ data[i].name }
                  </strong>
                  <small>
                    #{ data[i].username }
                  </small>
                </div>
              </li>") for i in [0..data.length-1]

  $(".people").on "click", ".user", ->
    $("#to").val($(this).attr("data-username"))
    $("#conversation_receiver_id").val($(this).attr("data-user-id"))