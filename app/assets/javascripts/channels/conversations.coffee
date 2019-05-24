$(document).on "turbolinks:load", ->
  messages_to_bottom = -> messages.scrollTop(messages.prop("scrollHeight"))
  messages = $(".PM_conversation_container")

  App.conversations = App.cable.subscriptions.create "ConversationsChannel",

    connected: ->
      # Called when the subscription is ready for use on the server

    disconnected: ->
      # Called when the subscription has been terminated by the server

    received: (data) ->
      # Called when there's incoming data on the websocket for this channel
      messages = $(".PM_conversation_container")
      if messages.data('conversation-id') is data['conversation_id']
        messages.append data['message']
        messages_to_bottom()
    
    send_message: (message, conversation_id) ->
      @perform 'send_message', message: message, conversation_id: conversation_id

  if messages.length > 0
    messages_to_bottom()
  $(document).on 'submit', '#new_personal_message', (e) ->
    $this = $(this)
    textarea = $this.find('#personal_message_body')
    if $.trim(textarea.val()).length > 1
      App.conversations.send_message textarea.val(), $this.find('#personal_message_conversation_id').val()
      textarea.val('')
    $("#send_message").prop("disabled", false);
    return false