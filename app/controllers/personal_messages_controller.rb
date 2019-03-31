class PersonalMessagesController < ApplicationController
    def create
        @personal_message = current_user.personal_messages.build(personal_message_params)
        @personal_message.conversation_id = params[:conversation_id]
        
        respond_to do |format|
            if @personal_message.save
                format.html { redirect_to @personal_message.conversation }
                format.js
            else
                format.html { redirect_to @personal_message.conversation, notice: @personal_message.errors }
                format.js
            end
        end
    end

    protected

    def personal_message_params
        params.require(:personal_message).permit(:body, :conversation_id)
    end
end
