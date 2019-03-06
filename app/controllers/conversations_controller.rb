class ConversationsController < ApplicationController
    before_action :authenticate_user!
    before_action :check_if_exists, only: [:create]
    before_action :set_conversation, only: [:show, :destroy]
    #after_action :destroy_if_empty, only: [:show]

    def index
        @conversations = Conversation.participates(current_user).order(updated_at: "DESC")
        respond_to do |format|
            format.html
            format.js
        end
    end

    def new
        @conversation = Conversation.new
        respond_to do |format|
            format.html
            format.js
        end
    end

    def create
        
        @conversation = current_user.authored_conversations.build(conversation_params)
        if @conversation.save
            respond_to do |format|
                format.js
            end
        end
    end

    def show
        @personal_message = PersonalMessage.new
        mark_as_read(@conversation.personal_messages.unread(current_user))
        respond_to do |format|
            format.html
            format.js
        end
    end

    def destroy
        if @conversation.destroy
            redirect_to conversations_path
        end
    end

    protected

    def set_conversation
        @conversation = Conversation.find(params[:id])
    end

    def conversation_params
        params.require(:conversation).permit(:receiver_id)
    end

    def check_if_exists
        @conversation = Conversation.between(current_user, User.find(params[:conversation][:receiver_id])).first
        if @conversation
            @personal_message = PersonalMessage.new
            render "show", conversation: @conversation, personal_message: @personal_message
        end
    end

    def mark_as_read(messages)
        messages.update_all(read_at: Time.now)
    end

    def destroy_if_empty
        @conversation.destroy if @conversation.personal_messages.empty?
    end
end
