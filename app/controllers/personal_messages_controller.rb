class PersonalMessagesController < ApplicationController
    def create
        @personal_message = current_user.personal_messages.build(personal_message_params)
        @personal_message.conversation_id = params[:conversation_id]
        if @personal_message.save
            redirect_to @personal_message.conversation
        end
    end

    protected

    def personal_message_params
        params.require(:personal_message).permit(:body)
    end
end
