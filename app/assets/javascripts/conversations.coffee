# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->

  search_user = ->
    $.ajax '/users', 
      type: "GET",
      dataType: "JSON",
      data: { 
          term: $("#to").val()
      }
      success: (data) ->
        if data.errors
          $(".people").html("<h3>#{ data.errors }</h3>")
        else
          $(".people").html("")
          $(".people").append("
            <li class='user list-group-item' data-username=#{ data[i].username } data-user-id=#{ data[i].id }>
              <div class='user-avatar'>
                <img src=#{ data[i].avatar } alt='user avatar' />
              </div>
              <div class='username'>
                <strong>
                  #{ data[i].name }
                </strong>
                <small>
                  #{ data[i].username }
                </small>
              </div>
            </li>") for i in [0..data.length-1]
  
  $(".modal").on "keyup", "#to", ->
    search_user()
  $("#to").on "keyup", ->
    search_user()

  $(".people").on "click", ".user", ->
    $("#to").val($(this).attr("data-username"))
    $("#conversation_receiver_id").val($(this).attr("data-user-id"))

  $(".modal-body").on "click", ".user", ->
    $("#to").val($(this).attr("data-username"))
    console.log($(this))
    $("#conversation_receiver_id").val($(this).attr("data-user-id"))

  