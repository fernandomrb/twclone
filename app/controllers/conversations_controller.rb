class ConversationsController < ApplicationController
    before_action :authenticate_user!
    before_action :check_if_exists, only: [:create]
    after_action :destroy_if_empty, only: [:show]

    def index
        @conversations = Conversation.participates(current_user).order(updated_at: "DESC")
    end

    def new
        @conversation = Conversation.new
    end

    def create
        
        @conversation = current_user.authored_conversations.build(conversation_params)
        if @conversation.save
            respond_to do |format|
                format.html { redirect_to @conversation }
            end
        end
    end

    def show
        @conversation = Conversation.find(params[:id])
        @personal_message = PersonalMessage.new
    end

    protected

    def conversation_params
        params.require(:conversation).permit(:receiver_id)
    end

    def check_if_exists
        @conversation = Conversation.between(current_user, User.find(params[:conversation][:receiver_id])).first
        if @conversation
            redirect_to @conversation
        end
    end

    def destroy_if_empty
        @conversation.destroy if @conversation.personal_messages.empty?
    end
end
