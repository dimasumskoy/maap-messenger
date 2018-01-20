require 'rails_helper'

RSpec.describe ConversationsController, type: :controller do
  sign_in_user

  let!(:user2) { create(:user) }

  describe 'GET #index' do
    let!(:conversation) { create(:conversation, sender: @user, recipient: user2) }

    before { get :index }

    it 'gets an array of user conversations' do
      expect(assigns(:conversations)).to eq ([conversation])
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    let!(:conversation) { create(:conversation, sender: @user, recipient: user2) }

    before { get :show, params: { id: conversation }}

    it 'assigns the requested conversation' do
      expect(assigns(:conversation)).to eq conversation
    end

    it 'assigns a new message' do
      expect(assigns(:message)).to be_a_new(Message)
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'POST #create' do
    context 'conversation exists' do
      let!(:conversation) { create(:conversation, sender: @user, recipient: user2) }

      before { post :create, params: { user_id: user2.id } }

      it 'finds a conversation' do
        expect(assigns(:conversation)).to eq conversation
      end

      it 'redirects to conversation' do
        expect(response).to redirect_to conversation_path(conversation)
      end
    end

    context 'conversation not found' do
      let!(:user) { create(:user) }

      it 'creates new conversation' do
        expect { post :create, params: { user_id: user.id } }.to change(Conversation, :count).by(1)
      end

      it 'increases amount of conversations for current user' do
        expect { post :create, params: { user_id: user.id } }.to change(@user.conversations, :count).by(1)
      end

      it 'redirects to new conversation' do
        post :create, params: { user_id: user.id }
        expect(response).to redirect_to conversation_path(assigns(:conversation))
      end
    end
  end
end
